
module ChinaUnicomApi
  class Cuparser 
    def self.convert(params_hash)
      return new(params_hash).get_data 
    end


    def initialize(params_arr=[])
      @params_arr = params_arr
      @leg_sint32  = 8
			@leg_string  = 2
      @buffer_size = ''
      @buffer_arr = []

    end

    def get_data
      struct_multi
      return @buffer_arr.join("")
    end


    def struct_multi

      tablecount
      @params_arr.each do |table| #table
        
        table_class = proxy_class(table['tablename'])

        bw_table_name_and_size(table)  # 
        bw_rowsdatacount(table) #
        table['rowsdata'].each do |rows|
          bw_rowcount(rows) #
          rows_colums(table_class,rows)
        end #rowsdata
      end #table

    end#struct_multi


    def rows_colums(table_class,rows)
      rows.each do |row_key,row_value|
        row_field_value(row_key,row_value,table_class)
      end
    end


    def row_field_value(row_key,row_value,table_class)   
      @buffer_arr << to_csint32(row_key.size) #name_size
      @buffer_arr << row_key #to_cstring(row_key)


      if row_value!=''

        ctype = table_class.ctype(row_key)
        #puts ">>>>>>#{ctype}>>>>>#{row_value.size}: #{row_value}"
        case ctype
          when 'int'
            cggrow = to_csint32(4) #int(4)
            @buffer_arr << cggrow
            @buffer_arr << to_csint32(row_value) #to_csint32(row_value)

           # puts ">>>>>>int>>>cggrow>>#{cggrow.inspect}"
           # puts ">>>>>int>>>>>>>>>>>#{row_value}"
            #puts ">>>>>>>>fuck>>#{row_key}>>#{row_value}>>>>#{to_csint32(row_value).inspect }"
          when 'byte'
            @buffer_arr << to_csint32(row_value.to_s.size) #size 
            @buffer_arr << row_value #to_cstring(row_value)      #value     
          #  puts ">>>>>byte>>>>>>>>>>>#{row_value}"
        else 
          @buffer_arr << to_csint32(row_value.to_s.size) #size 
          @buffer_arr << row_value #to_cstring(row_value)      #value
        end

      else
        @buffer_arr << to_csint32(0)
      end

      @buffer_arr << row_ressize
    end



    def proxy_class(name)
      name = ActiveSupport::Inflector.camelize(name)
      "ChinaUnicomApi::RequestModels::#{name}".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
    rescue
      raise UnableToFindClass,"Unable To Find '#{name.camelize}' Class" #DOTO raise this class exits
    end


    def row_ressize
      to_csint32(0)
    end

    def bw_rowsdatacount(table)
      @buffer_arr << to_csint32(table['rowsdata'].size)
    end

    def bw_rowcount(rows)
      @buffer_arr << to_csint32(rows.size)
    end

 
    def bw_table_name_and_size(table)
      name_str = to_cstring(table['tablename'])
      @buffer_arr << to_csint32(name_str.size.to_i/@leg_string) #size
      @buffer_arr << table['tablename'] #name_str                         #name
    end

    #tablecount 
    def tablecount
      @buffer_arr << to_csint32(@params_arr.size)
    end


    def to_cstring(v)
      v.unpack("H*").to_s
    end


    def to_cbytes(v)
      case v.size
      when 1 then return "#{to_csint32(0)}#{to_csint32(v)}"
      when 2 then return to_csint32(v).to_s
      end 
    end

    
    def to_csint32(v)
      Array("%08x" % v).pack("H*")
    end

  end
end


# 1.8.7 :030 > "0000000"+12.to_s(16)
#  => "0000000c" 
# 1.8.7 :031 > ("0000000"+12.to_s(16)).hex
#  => 12 


# 1.8.7 :001 > '00000001'.hex
#  => 1 

# 1.8.7 :002 > '00000005'.hex
#  => 5 


# "6c6f67696e".to_a.pack("H*")
# =>login

# 1.8.7 :017 > 'login'.unpack("H*")
#  => ["6c6f67696e"] 

# 1.8.7 :022 > "76657273696f6e".to_a.pack("H*")
#  => "version" 




