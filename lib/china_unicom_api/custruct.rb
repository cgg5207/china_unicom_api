module ChinaUnicomApi

  class UnableToFindClass < StandardError; end

  class Custruct

    def self.convert(hashdata,module_cname="ChinaUnicomApi::")
      return new(hashdata,module_cname).data_convert_class
    end


  	def initialize(hashdata,module_cname= "ChinaUnicomApi::")
      @hashdata = hashdata
      @module_cname= module_cname
    end


    def proxy_class(name)
      @module_cname||="ChinaUnicomApi::"
      name = ActiveSupport::Inflector.camelize(name)
      "#{@module_cname}#{name}".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
    rescue
      raise UnableToFindClass,"Unable To Find '#{name.camelize}' Class" #DOTO raise this class exits
    end


    def self.page_info_tablename
    	['top','listcomment']
    end


    def data_convert_class
      table_class_arr = []
      pageinfo_class  = {}
      #puts @hashdata.inspect
      @hashdata.each do |tab|
        tablename = tab['tablename'] #表名

        tab['columns'].each do |column|
        	
        	if self.class.page_info_tablename.include?(tablename)
        	  pageinfo_class =  pagetable(column,tablename)
        	else
	          class_data = instance_table(column,tablename)
	          #返回单条与多条数据
	          #if @hashdata.size.to_i == 1
	          #	return custom_boolean_status( class_data )
	          #else
	          	table_class_arr <<  class_data
	        	#end
        	end

        end
      end

      #返回单条与多条数据
      if table_class_arr.size.to_i==1
        return custom_boolean_status( table_class_arr.first )
      end

      
      unless pageinfo_class.empty?
      	page     =  pageinfo_class['pagenum']
      	total    =  pageinfo_class['totalrows']
      	per_page =  pageinfo_class['returnrows']
      	ChinaUnicomApi::Collection.create(page, per_page, total) do |pager|
      		pager.replace(table_class_arr)
      	end
      else


        rmaillogin = ['ChinaUnicomApi::Loginresult','ChinaUnicomApi::Maillogin']
        if table_class_arr and table_class_arr.size.to_i>1 && table_class_arr.map{|x| rmaillogin.include?( x.class.to_s ) }
          table_class_arr.each do |talogin|
            custom_boolean_status(talogin) if talogin.class.to_s=='ChinaUnicomApi::Loginresult'
            return talogin                 if talogin.class.to_s=='ChinaUnicomApi::Maillogin'
          end
        else 
          return table_class_arr
        end

      end

    end


    def custom_boolean_status(struct_response)
      #puts struct_response.inspect
      if struct_response.class.this_instance_return_boolean
        case struct_response.result
          when 0
            struct_response
          when 2
            struct_response
        else
          raise ChinaUnicomApi::Errors::CuReport.new(struct_response.desc)
        end
      else
        struct_response
      end        
    end


    def pagetable(column,tablename)
			hash = {}
    	insvar = instance_table(column,tablename)
    	#convert Object to Hash
    	insvar.instance_variables.each {|var| hash[var.to_s.delete("@")] = insvar.instance_variable_get(var) }
    	return hash
    end


    def instance_table(column,tablename)
      table_class = proxy_class(tablename)
      class_data  = table_class.new
      column.keys.map{|key|    
       begin
          ctype = table_class.ctype(key)      
          class_data.send("#{key}=", ChinaUnicomApi::Parser.convert_bufdata(column[key], "#{ctype}") ) if ctype
       rescue ChinaUnicomApi::Errors::Parser.new
         raise ChinaUnicomApi::Errors::Parser.new
       rescue Exception => e
          #TODO 日志
       end            
      }    	
      return class_data
    end

  end
end   