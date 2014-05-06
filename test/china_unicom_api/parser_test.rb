require File.expand_path(File.dirname(__FILE__) + '/../test_helper')


class ParserTest < Test::Unit::TestCase

  def test_parser_login
    login_a   = ChinaUnicomApi::Parser.convert load_file_bin("login_bin.txt")
#login_a.inspect
    assert_equal login_a.infoflag,0
    assert_equal login_a.messmaxlen,150
    assert_equal login_a.phonenum,"15555215554"
    assert_equal login_a.rmmeslen,500
    assert_equal login_a.sessionid,"8c6fa303c0f14b838ee142516d82d992"
    assert_equal login_a.version,"android_v2.3.0"
    assert_equal login_a.uainfo,"Android"
    assert_equal login_a.ua,"9000000000"
    assert_equal login_a.outboxmax,150
    assert_equal login_a.desc,"不需要升级"
    assert_equal login_a.inboxmax,150
  end


  def test_parser_category
    category_a = ChinaUnicomApi::Parser.convert load_file_bin("category_bin.txt")
  	assert_equal category_a.class.to_s,'ChinaUnicomApi::Collection'
  	assert_equal category_a.current_page,1
  	assert_equal category_a.per_page,10
  	assert_equal category_a.total_entries,100
  	assert_equal category_a.size,10
  end

  def test_parser_getverifycode
    begin
      ChinaUnicomApi::Parser.convert load_file_bin("getverifycode_1.txt")
    rescue Exception => e
      assert_equal e.to_s,"请输入联通号码进行注册"
    end
  end


  def test_maillogin
    begin
      ChinaUnicomApi::Parser.convert load_file_bin("maillogin_error.txt")
    rescue Exception => e
      assert_equal e.to_s,"密码错误，登录失败"
    end
    
    maillogin = ChinaUnicomApi::Parser.convert load_file_bin("maillogin.txt")
    assert_equal maillogin.version,"android_v2.5.0"
    assert_equal maillogin.phonenum,"lxmxhh@163.com"
    assert_equal maillogin.infoflag,1
    assert_equal maillogin.inboxmax,150
    assert_equal maillogin.uainfo,"Android"
  end

  def test_productdetail
    productdetail = ChinaUnicomApi::Parser.convert load_file_bin("productdetail.bin.txt")
    assert_equal productdetail.sizeinfo,"1612KB"
    assert_equal productdetail.appid,"23134" 
    assert_equal productdetail.ispromotion,0
    assert_equal productdetail.type,0 
    assert_equal productdetail.priceinfo,"0.0元"
    assert_equal productdetail.id,"23134"
    assert_equal productdetail.updatetime,"20121108105913"
    assert_equal productdetail.donoteisfree,0
    assert_equal productdetail.rate,4
    assert_equal productdetail.isfree,0
    assert_equal productdetail.name,"沃商店手机客户端"
    assert_equal productdetail.price,0 
    assert_equal productdetail.icon,"http://client.wostore.cn:6106/appstore_agent/upload/file/90399395/9039939520110506361800/middle.png"
    assert_equal productdetail.size,1612
    assert_equal productdetail.appdate,"20110804152136"
    assert_equal productdetail.screenshots1,"http://client.wostore.cn:6106/appstore_agent/upload/90002869/cnt/23134/figure1.jpg"
    assert_equal productdetail.screenshots2,"http://client.wostore.cn:6106/appstore_agent/upload/90002869/cnt/23134/figure2.jpg"
    assert_equal productdetail.screenshots3,"http://client.wostore.cn:6106/appstore_agent/upload/90002869/cnt/23134/figure3.jpg"
    assert_equal productdetail.screenshots4,"http://client.wostore.cn:6106/appstore_agent/upload/90002869/cnt/23134/figure4.jpg"
    assert_equal productdetail.favoriteflag,0
    assert_equal productdetail.catagory,"应用,网络通信"
    assert_equal productdetail.iscommend,"1"
    assert_equal productdetail.supplier,"中国联合网络通信有限公司"
  end

  def load_file_bin(filename)
    File.read(File.dirname(__FILE__) + "/../../test/fixtures/#{filename}") #.unpack("H*")[0]
  end

end
