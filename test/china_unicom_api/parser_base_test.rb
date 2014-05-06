require File.expand_path(File.dirname(__FILE__) + '/../test_helper')


class ParserBase < Test::Unit::TestCase




  def test_custom_rest

	#parser_base_api('Login',load_file_bin("login_bin.txt"))
	#login_class = "ChinaUnicomApi::#{metoh}".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
	#parser_base_api('Userinfo',load_file_bin("userinfo.bin.txt"))
	#bcomments_bin = "\000\000\000\001\000\000\000\bcomments\000\000\000\001\000\000\000\003\000\000\000\tproductid\000\000\000\0049119\000\000\000\000\000\000\000\bcomments\000\000\000\002ok\000\000\000\000\000\000\000\004rate\000\000\000\0014\000\000\000\000".unpack("H*")[0]
	#bcomments_bin  = "\000\000\000\001\000\000\000\bcomments\000\000\000\001\000\000\000\003\000\000\000\tproductid\000\000\000\0049119\000\000\000\000\000\000\000\bcomments\000\000\000\002ok\000\000\000\000\000\000\000\004rate\000\000\000\001\000\000\000\004\000\000\000\000".unpack("H*")[0]
	#puts bcomments_bin
	#puts ">>>>>>>>>>>>>>>>#{bcomments_bin.size}"
	#comments_class = "ChinaUnicomApi::RequestModels::Comments".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
  	  	
	updateuserinfo_bin   = "000000010000000e75706461746575736572696e666f000000010000000f000000046e616d6500000006676766666767000000000000000667656e646572000000040000000000000000000000046e69636b00000006636767363434000000000000000361676500000004013305b700000000000000046d61696c00000000000000000000000669646361726400000000000000000000000c6465766963657479706569640000005b4d49203153204275696c642f494d4d37364429204170706c655765624b69742f3533342e333020284b48544d4c2c206c696b65204765636b6f292056657273696f6e2f342e30204d6f62696c65205361666172692f3533342e3330000000000000000868696465696e666f0000000101000000000000000b70686f6e657365617263680000000101000000000000000b616464746f667269656e640000000101000000000000000c766572696669636174696f6e0000000101000000000000000e72656365697665646576696e666f0000000101000000000000000e7265636569766564667269656e640000000101000000000000000f7265636569766564737472616e67650000000101000000000000000e726563656976656473797374656d000000010100000000"
	updateuserinfo_class = "ChinaUnicomApi::RequestModels::Updateuserinfo".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
	parser_base_api(updateuserinfo_class,updateuserinfo_bin)



    # table_arr =[];rowsdata_arr = []
    # rowdata_h = updateuserinfo_hash
    # rowsdata_arr << rowdata_h
    # table_arr    << {'tablename'=> "updateuserinfo",'rowsdata'=>rowsdata_arr}
    # updateuserinfo     = ChinaUnicomApi::Cuparser.convert(table_arr).unpack("H*")[0]
    #  updateuserinfo_a   = ChinaUnicomApi::Parser.new(updateuserinfo).get_data("ChinaUnicomApi::RequestModels::")
    # updateuserinfo_a.inspect

	 	#updateuserinfo_class = "ChinaUnicomApi::RequestModels::Updateuserinfo".to_s.split('::').reduce(Object){|cls, c| cls.const_get(c) }
    #parser_base_api(updateuserinfo_class,updateuserinfo)


  	assert_equal 1,1
  end







  def parser_base_api(login_class,databin)
	
		@leg_byte = @leg_string  =2
		@leg_sint32  = 8
		@buffer_size=0
  	@response_baby = databin

  	tablecount    = buffer_data(8)
  	tablenamesize = buffer_data(8)
  	tablename     = buffer_data( @leg_byte*tablenamesize.hex.to_i )
  	rowcount      = buffer_data(8)
  	columnconut   = buffer_data(8)
  	# puts "tablecount:#{tablecount}\n"+
  	# "tablenamesize:#{tablenamesize}\n"+
  	# "tablename:#{tablename}\n "+
  	# "rowcount:#{rowcount}\n "+
  	# "columnconut:#{columnconut}"

  	i=1
  	columnconut.hex.to_i.times do |x|
	  	namesize   = buffer_data(8)
		_name      = buffer_data(@leg_byte*namesize.hex.to_i).to_a.pack("H*")

	  	valuesize  = buffer_data(8)
		_value     = valuesize.hex.to_i==0 ? nil : buffer_data(@leg_byte*valuesize.hex.to_i) 
		
	  	column_type = login_class.ctype(_name)

	  	if _value
			case column_type
			when 'string' then  _value = _value.to_a.pack("H*") 
			when 'int'    then  _value = _value#.hex
			when 'byte'   then  _value = _value.hex
			end
		end

	  	ressize    = buffer_data(8)
	  	# puts "type: #{login_class.ctype(_name)} | "+
	  	# "namevalue #{_name}:#{_value}  "+
	  	# "namesize: #{namesize} |"+
	  	# " valuesize:#{valuesize}  "+
	  	# " #{_value}:#{_value} \n  "


	  	# puts "#{i}.type: #{login_class.ctype(_name)} | "+
	  	# "name(#{namesize.hex}): #{_name} | "+
	  	# "value(#{valuesize.hex}): #{_value}|@leg_byte: #{@buffer_size}\n "

	  	#puts "'#{_name}'=>'#{_value}',"
	  	i+=1

  	end  	
  end


  def updateuserinfo_hash

# ["\000\000\000\001", 
# 	"\000\000\000\016", 
# 	"updateuserinfo", 
# 	"\000\000\000\001", 
# 	"\000\000\000\017", 
# 	#
# 	"\000\000\000\016", "receivedfriend", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\f", "devicetypeid", "\000\000\000[", "MI 1S Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30", "\000\000\000\000", 
# 	"\000\000\000\004", "name", "\000\000\000\006", "ggffgg", "\000\000\000\000", 
# 	"\000\000\000\016", "receivedevinfo", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\v", "phonesearch", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\f", "verification", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\004", "nick", "\000\000\000\006", "cgg644", "\000\000\000\000", 
# 	"\000\000\000\006", "idcard", "\000\000\000\000", "\000\000\000\000", 
# 	"\000\000\000\004", "mail", "\000\000\000\000", "\000\000\000\000", 
# 	"\000\000\000\006", "gender", "\000\000\000\001", "\000\000\000\000", "\000\000\000\000", 
# 	"\000\000\000\v", "addtofriend", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\016", "receivedsystem", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\017", "receivedstrange", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\b", "hideinfo", "\000\000\000\001", "1", "\000\000\000\000", 
# 	"\000\000\000\003", "age", "\000\000\000\b", "\0013\005\267", "\000\000\000\000"]

		{
			'name'=>'ggffgg',
			'gender'=>'0'  ,
			'nick'=>'cgg644',
			'age'=>'20121015',
			'mail'=>'',
			'idcard'=>'',
			'devicetypeid'=>'MI 1S Build/IMM76D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30',
			'hideinfo'=>'1',
			'phonesearch'=>'1',
			'addtofriend'=>'1',
			'verification'=>'1',
			'receivedevinfo'=>'1',
			'receivedfriend'=>'1',
			'receivedstrange'=>'1',
			'receivedsystem'=>'1'
		}
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


end
