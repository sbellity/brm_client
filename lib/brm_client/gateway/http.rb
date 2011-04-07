require "rest_client"
module BrmClient
  module Gateway
    class Http
      attr_reader :connection, :collection
      def initialize opts
        host = opts[:host]
        port = opts[:port]
        path = opts[:path] || ""
        @endpoint = "http://#{host}:#{port}"
        @timeout = opts[:timeout] || 300
        @destination = opts[:queue] || opts[:application]
        @rest_client = RestClient::Resource.new(@endpoint, :timeout => @timeout)
      end
      
      def disconnect
      end
      
      def send_event e
        @rest_client.post :destination => @destination, :msg => e.to_json
      end
      
    end
  end
end