module BrmClient
  class Logger
    include BrmClient::Event
    
    def sequence_number
      @sequence_number ||= 0
      @sequence_number += 1
    end
    
    attr_reader :gateway, :application
    attr_accessor :facet_id, :user_id
    
    def initialize(application, gateway_type, *args)
     @application = application
     gateway_options = args.extract_options! || {}
     gateway_options[:application] = application
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
      event["metaData"] = {
        "timestamp" => Time.now.to_i * 1000,
        "eventName"  => event_name,
        "application" => application,
        "loggerVersion" => VERSION,
        "loggerType" => "ruby",
        "sequenceNumber" => sequence_number
      }
      event["metaData"]["eventRef"] = event_ref
      
      send_event event
    end
    
    
    
  end
end