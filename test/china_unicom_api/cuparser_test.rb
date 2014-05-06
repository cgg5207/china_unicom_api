require File.expand_path(File.dirname(__FILE__) + '/../test_helper')


class CuparserTest < Test::Unit::TestCase

  def test_parser_updateuserinfo
    table_arr =[]
    rowsdata_arr = []
    rowdata_h={}

    rowdata_h['name']='cgg1'

    rowdata_h['gender']='1'  
    rowdata_h['age']='12' 

    rowdata_h['nick']='cgg2'  
    rowdata_h['mail']='cgg5207@sina.com'  
    rowdata_h['idcard']='1'  
    rowdata_h['devicetypeid']='1'  
    rowdata_h['hideinfo']='1'  
    rowdata_h['phonesearch']='1' 
    rowdata_h['addtofriend']='2' 
    rowdata_h['verification']='1'  
    rowdata_h['receivedevinfo']='0'  
    rowdata_h['receivedfriend']='1'  
    rowdata_h['receivedstrange']='0' 
    rowdata_h['receivedsystem']='1'

    rowsdata_arr << rowdata_h
    table_arr   << {'tablename'=> "updateuserinfo",'rowsdata'=>rowsdata_arr}

    updateuserinfo     = ChinaUnicomApi::Cuparser.convert(table_arr).unpack("H*")[0]

    updateuserinfo_a   = ChinaUnicomApi::Parser.new(updateuserinfo).get_data("ChinaUnicomApi::RequestModels::")

    #puts rowdata_h['gender']
    assert_equal rowdata_h['nick'],updateuserinfo_a.nick #string type
    assert_equal rowdata_h['receivedsystem'],updateuserinfo_a.receivedsystem #byte type
  end






  # def test_parser_login

  #   updateuserinfo_a   = ChinaUnicomApi::Parser.new(load_file_bin("login_bin.txt")).get_data("ChinaUnicomApi::RequestModels::")
  #   updateuserinfo_a.inspect
  #   assert_equal 1,1
  # end










end
