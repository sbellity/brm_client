require "typhoeus"

module BrmClient
  module Gateway
    class Http
      attr_reader :connection, :collection
      def initialize opts
        host = opts[:host]
        port = opts[:port]
        @endpoint_url = "http://#{host}:#{port}/s.php"
        @timeout = opts[:timeout] || 300
      end
      
      def disconnect
      end
      
      def send_event e
        options = {
          :body => e.to_json,
          :timeout => @timeout
        }
        request = Typhoeus::Request.post(@endpoint_url, options)
      end
      
    end
  end
end