require "stomp"

module BrmClient
  module Gateway
    class Stomp
      attr_reader :client, :queue
      
      def initialize opts
        hosts = opts[:hosts] || [ opts[:host] ]
        hosts.map! &:to_options
        @client = ::Stomp::Client.new({ :hosts => hosts })
        @queue = "/queue/#{opts[:application]}"
      end
      
      def disconnect
      end
      
      def send_event e
        @client.publish(@queue, e.to_json)
      end
      
    end
    
  end
end