require "typhoeus"

module BrmClient
  module Gateway
    class Http
      attr_reader :connection, :collection
      def initialize opts
        host = opts[:host]
        port = opts[:port]
        path = opts[:path] || ""
        @endpoint_url = "http://#{host}:#{port}/#{path}"
        @timeout = opts[:timeout] || 300
        @destination = opts[:queue] || opts[:application]
      end
      
      def disconnect
      end
      
      def send_event e
        options = {
          :params => { :destination => @destination, :msg => e.to_json },
          :timeout => @timeout
        }
        request = Typhoeus::Request.post(@endpoint_url, options)
      end
      
    end
  end
end