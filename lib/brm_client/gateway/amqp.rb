require "bunny"

module BrmClient
  module Gateway
    class Amqp
      attr_reader :connection, :queue
      
      def initialize opts
        @connection = Bunny.new({
          :logging => opts[:logging] || false,
          :host => opts[:host] || "localhost",
          :port => opts[:port] || 5672,
          :user => opts[:user] || "guest",
          :pass => opts[:pass] || "guest",
          :vhost => opts[:vhost] || "/"
        })
        
        @connection.start
        @queue = @connection.queue "reactor.#{opts[:application]}"
      end
      
      def disconnect
        @connection.stop
      end
      
      def send_event e
        @queue.publish(e.to_json)
      end
      
    end
    
  end
end