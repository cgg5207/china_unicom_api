require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class FtpPaser < Test::Unit::TestCase

  def test_ftp_app_req
  	data = ChinaUnicomApi::FtpParser::Base.get_data('app_req',load_file_bin("107_20121019_app_req_1.txt"))
  	first_data = data.first
  	
	assert_equal data.datetime,'20121019150216'
	assert_equal data.size,data.total

	assert_equal first_data.iconurl4,"http://store.wo.com.cn/upload/"
	assert_equal first_data.iconurl3,"http://store.wo.com.cn/upload/90002616/cnt/50560/figure3.jpg"
	assert_equal first_data.category,"阅读"
	assert_equal first_data.iconurl1,"http://store.wo.com.cn/upload/90002616/cnt/50560/figure1.jpg"
	assert_equal first_data.sourcetype,"107"
	assert_equal first_data.rate_count,""
	assert_equal first_data.dlcount,"-1" 
	assert_equal first_data.iconurl,"http://store.wo.com.cn/upload/90002616/cnt/50560/small.png"
	assert_equal first_data.iconurl2,"http://store.wo.com.cn/upload/90002616/cnt/50560/figure2.jpg"
	assert_equal first_data.optype,"1"
	assert_equal first_data.price,"0" 
	assert_equal first_data.rate,""
	assert_equal first_data.publishtime,"20120401153711"
	assert_equal first_data.productid,"50560"
  end



  def test_ftp_soft_req
  	data = ChinaUnicomApi::FtpParser::Base.get_data('soft_req',load_file_bin("107_20121019_soft_req_1.txt"))
  	first_data = data.first

	assert_equal  data.datetime,'20121019150222'
	assert_equal data.size,data.total

	assert_equal first_data.size,'492168'
	assert_equal first_data.productid,'9023823020101109710200'
	assert_equal first_data.size,'492168'
	assert_equal first_data.productid,'9023823020101109710200'
	assert_equal first_data.size,'492168'
	assert_equal first_data.productid,'9023823020101109710200'
	assert_equal first_data.sourcetype,nil
	assert_equal first_data.handsetid,'107'
	assert_equal first_data.downloadurl,'file/90238230/9023823020101109710200/1/'
	assert_equal first_data.os,'4'
	assert_equal first_data.version,''
	assert_equal first_data.packagename,'baidumobile_2010beta2_java_kj_1076a.rar<Br/>baidumobile_2010beta2_java_kj_1076a.jar<Br/>baidumobile_2010beta2_java_kj_1076a.jad'

  end
end
