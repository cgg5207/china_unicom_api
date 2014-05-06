module ChinaUnicomApi
  class Collection < Array
    attr_reader :current_page, :per_page, :total_entries
    def initialize(page, per_page, total)
      @current_page = page.to_i
      @per_page = per_page.to_i
      @total_entries = total
    end    

    def self.create(page, per_page, total)
      pager = new(page, per_page, total)
      yield pager
      pager
    end

    def replace(array)
      super
    end    
  end
end  