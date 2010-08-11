module BrmClient
  module Gateway
    class Debug
      def initialize opts
        @logger = opts[:logger]
      end
      
      def disconnect
      end
      
      def send_event e
        @logger.info "# BRM Event : #{e.inspect}" unless @logger.nil?
      end
      
    end
  end
end