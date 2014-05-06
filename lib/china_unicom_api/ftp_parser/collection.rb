module ChinaUnicomApi
  module FtpParser  
    class Collection < Array
      attr_reader :datetime, :total
      def initialize(datetime, total)
        @total = total.to_i
        @datetime = datetime
      end    

      def self.create(datetime, total)
        pager = new(datetime, total)
        yield pager
        pager
      end

      def replace(array)
        super
      end    
    end
  end
end  