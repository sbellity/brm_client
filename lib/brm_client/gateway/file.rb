require "mongo"

module BrmClient
  module Gateway
    class File
      attr_reader :path, :file
      def initialize opts
        @path = opts[:path] || "/tmp/#{opts[:application]}.log"
        @file = open(@path, "w")
      end
      
      def disconnect
        @file.close
      end
      
      def send_event e
        @file.write "#{e.to_json}\n"
      end
      
    end
  end
end