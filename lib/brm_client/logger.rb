module BrmClient
  class Logger
    include BrmClient::Event
    
    def sequence_number
      @sequence_number ||= 0
      @sequence_number += 1
    end
    
    attr_reader :gateway, :application
    attr_accessor :facet_id, :user_id
    
    def initialize(application, gateway_options = {}, opts={})
     @application = application
     @options = {
       :timestamp_format => "timestamp"
     }.merge(opts)
     gateway_type = gateway_options.delete(:type) || "File"
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
      event["context"] = context || {}
      
      event["data"]["agent"] = {:id => facet_id.to_s, :type => "facet"} if facet_id
      
      if user_id
        event["data"]["agent"] ||= {:id => user_id.to_s, :type => "user"}
        event["context"]["userID"] = user_id
      end
      
      timestamp = case @options[:timestamp_format]
        when "timestamp" then Time.now.to_i
        when "string" then (Time.now.to_i).to_s
        when "time" then Time.now
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