module BrmClient
  module Gateway
    class Debug
      def initialize logger = nil
        @logger = logger
      end
      
      def disconnect
      end
      
      def send_event e
        dbg = "# BRM Event : #{e.inspect}"
        if !@logger.nil?
          @logger.info dbg
        else
          puts dbg
        end
      end
      
    end
  end
end