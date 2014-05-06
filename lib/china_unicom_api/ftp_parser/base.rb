require 'iconv'

module ChinaUnicomApi
  module FtpParser	
		class Base



			def self.get_data(rep_name,text)
				
				@rep_name = rep_name
				datetime,total="",0				
				table_class_arr=[]
		    text.each_with_index do |x,i|
		    	if i == 0 
		    		datetime,total=set_req_head(x) 
		    	else
		    		table_class_arr << set_req_fields(x)
		    	end	
		    end
      	ChinaUnicomApi::FtpParser::Collection.create(datetime,total) do |pager|
      		pager.replace(table_class_arr)
      	end
			end


			def self.set_req_head(x)
    		str = x.split("\t")
    		return str[0],filter_character(str[1])
			end


			def self.set_req_fields(x)
				tmp_class =proxy_class(@rep_name)
				class_new = tmp_class.new
				x.split("\t").each_with_index do |x1,jj|
					class_new.send("#{tmp_class.app_fields[jj+1]}=","#{filter_character(to_uft8(x1))}")
				end   		
				return class_new
			end

		  def self.to_uft8(str)
		  	Iconv.conv("utf8",'gbk',str)
		  end			

	    def self.proxy_class(name)
	      name = ActiveSupport::Inflector.camelize(name)
	      "ChinaUnicomApi::FtpParser::#{name}".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
	    rescue
	      raise UnableToFindClass,"Unable To Find '#{name.camelize}' Class" #DOTO raise this class exits
	    end

	    def self.filter_character(str)
	    	return str if str==''
	    	str.gsub("\r\n",'')
	    end

		end
  end
end