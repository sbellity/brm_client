require "mongo"

module BrmClient
  module Gateway
    class Mongo
      attr_reader :connection, :collection
      def initialize opts
        @connection = ::Mongo::Connection.new({
          :host => opts[:host] || "localhost",
          :port => opts[:port] || ::Mongo::Connection::DEFAULT_PORT
        })
        @collection = @connection.db(opts[:db] || opts[:application]).collection(opts[:collection] || "logs")
      end
      
      def disconnect
      end
      
      def send_event e
        collection.insert(e)
      end
      
    end
  end
end