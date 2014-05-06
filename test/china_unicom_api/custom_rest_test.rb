require File.expand_path(File.dirname(__FILE__) + '/../test_helper')


class CustomRest < Test::Unit::TestCase

  def test_custom_rest
    getverifycode   = ChinaUnicomApi::CustomRest.rest_method('getverifycode')
    test_resturl    =  ChinaUnicomApi::CustomRest.rest_method('test_resturl')
    default_resturl = ChinaUnicomApi::CustomRest.default_resturl
    
    assert_equal test_resturl,default_resturl+'test_resturl'
    assert_equal getverifycode,'/appstore_agent/getverifycode.do'
  end

end
