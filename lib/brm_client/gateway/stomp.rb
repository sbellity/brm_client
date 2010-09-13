require "stomp"

module BrmClient
  module Gateway
    class Stomp
      attr_reader :client, :queue
      
      def initialize opts
        hosts = opts[:hosts] || [ opts[:host] ]
        @client = Stomp::Client.new({ :hosts => hosts })
        @queue = @connection.queue "reactor.#{opts[:application]}"
      end
      
      def disconnect
      end
      
      def send_event e
        @client.send(@queue, e.to_json)
      end
      
    end
    
  end
end