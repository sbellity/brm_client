module BrmClient
  class Logger
    include BrmClient::Event
    
    def sequence_number
      @sequence_number ||= 0
      @sequence_number += 1
    end
    
    attr_reader :gateway, :application
    attr_accessor :facet_id, :user_id
    
    def initialize(application, gateway_options = {}, *opts)
     @application = application
     @options = {
       :timestamp_format => "time"
     }.merge(opts.extract_options! || {})
     gateway_type = gateway_options.delete("type") || "File"
     gateway_options[:application] ||= application
     @gateway = BrmClient::Gateway.const_get(gateway_type).new(gateway_options)
    end
    
    def disconnect
      @gateway.disconnect
    end
    
    private 
    
    def send_event e
      @gateway.send_event(e)
    end
    
    def event(event_name, data=nil, context=nil, event_ref="")
      event = HashWithIndifferentAccess.new
      event["data"] = data || {}
      event["context"] ||= {}
      
      event["data"]["agent"] = {:id => facet_id, :type => "facet"} if facet_id
      
      if user_id
        event["data"]["agent"] ||= {:id => user_id, :type => "user"}
        event["context"]["userID"] = user_id
      end
      
      puts "timestamp_format : #{@options[:timestamp_format]}"
      
      timestamp = case @options[:timestamp_format]
        when "timestamp" then Time.now.to_i * 1000
        when "string" then (Time.now.to_i * 1000).to_s
        else Time.now
      end
      
      event["metaData"] = {
        "eventName"  => event_name,
        "application" => application,
        "timestamp" => timestamp,
        "loggerVersion" => VERSION,
        "loggerType" => "ruby",
        "sequenceNumber" => sequence_number
      }
      event["metaData"]["eventRef"] = event_ref
      
      send_event event
    end
    
  end
end