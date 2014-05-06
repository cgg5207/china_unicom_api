
module ChinaUnicomApi
  class Parser 
    def self.convert(response)
      return new(response).get_data 
    end


    def initialize(response)
      @response_baby  = (response.body.unpack("H*")[0] rescue response)
      #@response_baby  = response.respond_to?("body") ? response.body.unpack("H*")[0] : response 
      @leg_sint32  = 8
			@leg_string  = 2
      @buffer_size = 0
    end

    def get_data(module_cname="ChinaUnicomApi::")
      ChinaUnicomApi::Custruct.convert(struct_data_multi,module_cname)
    end


    def self.convert_bufdata(buf,type=nil)
      case type
      when  nil     then return buf
      when 'byte'   then return buf.hex.to_i
      when 'int'    then return buf.hex.to_i
      when 'string' then return (buf.to_a.pack("H*") rescue nil)
      end      
    end


    private
    def struct_data_multi
      table_arr=[]
      @tablecount    = buffer_data(@leg_sint32).hex
      @tablecount.times{|x|
        @tablenamesize = buffer_data(@leg_sint32).hex
        @tablename     = buffer_data(@tablenamesize*@leg_string).to_a.pack("H*")
        @rowcount      = buffer_data(@leg_sint32).hex
        columns_arr =[]
        @rowcount.times{|rc| 
           @columnconut = buffer_data(@leg_sint32).hex
           columns_arr  << rowdata(@columnconut)
        }
        table_arr   << {'tablename'=>@tablename,'rowcount'=>@rowcount,'columns'=>columns_arr}
      }
      #puts table_arr.inspect
      return table_arr
    end


    def rowdata(column_conut)
      h = {}
      column_conut.times{|x|
        _name    = parser_fields('string')
        _value   = parser_fields
        _resdata = parser_fields
        h.merge!({"#{_name}"=>_value})
      }
      return h
    end



    def record_buffer(leg)
      @buffer_size+= leg.to_i
      return @buffer_size,leg
    end


    def buffer_data(leg)
      str =@response_baby[@buffer_size.to_i,leg.to_i]
      record_buffer(leg)
      return str
    end


    def parser_fields(type=nil)
      namesize = buffer_data(@leg_sint32).hex
      #return  namesize!=0 ? buffer_data(namesize*@leg_string ) : nil
      if namesize!=0
        buf = buffer_data(namesize*@leg_string)
        # puts ">>>>>>#{type}>>>>#{self.class.convert_bufdata(buf,type)}>>>>>>>>#{buf}"

        return self.class.convert_bufdata(buf,type)
      else
        return nil
      end
    rescue
      raise ChinaUnicomApi::Errors::Parser.new
    end


  end
end



