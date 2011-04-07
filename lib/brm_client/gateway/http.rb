require "rest_client"
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
        @rest_client = RestClient::Resource.new(@endpoint_url, :timeout => @timeout)
      end
      
      def disconnect
      end
      
      def send_event e
        @rest_client.post :destination => @destination, :msg => e
      end
      
    end
  end
end