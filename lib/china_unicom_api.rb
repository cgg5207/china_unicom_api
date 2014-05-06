module ChinaUnicomApi
  class << self
    def load_configuration(yaml_file)
      if File.exist?(yaml_file)
        if defined? RAILS_ENV
          config = YAML.load_file(yaml_file)[RAILS_ENV] 
        else
          config = YAML.load_file(yaml_file)           
        end
        apply_configuration(config)
      else
      	raise "china_unicom_api.yaml is not exist."
      end
    end

    def apply_configuration(config)
      ENV['CUAPI_APP_KEY']      = config['app_key'].to_s
      ENV['CUAPI_APP_SECRET']   = config['app_secret'].to_s
      ENV['CUAPI_ENDPOINT']     = config['endpoint'].to_s
      ENV['CUAPI_TIMEOUT']      = config['timeout'].to_s
      ENV['CUAPI_HTTP_PROXY']   = config['http_proxy'].to_s
      ENV['CUAPI_HTTP_PROXYADDR']     = config['http_proxyaddr'].to_s
      ENV['CUAPI_HTTP_PROXYPORT']     = config['http_proxyport'].to_s
      ENV['CUAPI_FTP_SERVER']     = config['ftp_server'].to_s
      ENV['CUAPI_FTP_PORT']       = config['ftp_port'].to_s
      ENV['CUAPI_FTP_NAME']       = config['ftp_name'].to_s
      ENV['CUAPI_FTP_PASSWD']     = config['ftp_passwd'].to_s
      ENV['CUAPI_SNS_ENDPOINT']     = config['sns_endpoint'].to_s
      ENV['CUAPI_SNS_SOURCE']       = config['sns_source'].to_s
      ENV['CUAPI_SNS_AUTHCODE']     = config['sns_authcode'].to_s
      ENV['CUAPI_CHANNELID']        = config['sns_channelid'].to_s
      ENV['CUAPI_WEB_ENDPOINT']     = config['web_endpoint'].to_s
      ENV['CUAPI_3DEC_KEY']         = config['3dec_key'].to_s
      ENV['CUAPI_CLIENT_CHANNEL_FLAG'] = (config['clientchannelflag']||'9').to_s
    end
  end
end   


require 'rubygems'
require 'active_support'
require 'china_unicom_api/cuparser'
require 'china_unicom_api/parser'
require 'china_unicom_api/errors'
require 'china_unicom_api/custruct'
require 'china_unicom_api/collection'
require 'china_unicom_api/version'
require 'china_unicom_api/model'
require 'china_unicom_api/logging'
require 'china_unicom_api/custom_rest'

require 'china_unicom_api/models/register'
require 'china_unicom_api/models/login'
require 'china_unicom_api/models/productlist'
require 'china_unicom_api/models/top'
require 'china_unicom_api/models/loginresult'
require 'china_unicom_api/models/userinfo'
require 'china_unicom_api/models/productdetail'

require 'china_unicom_api/models/getverifycode'
require 'china_unicom_api/models/getpassword'
require 'china_unicom_api/models/phonems'
require 'china_unicom_api/models/modifypass'
require 'china_unicom_api/models/updateuserinfo'
require 'china_unicom_api/models/order'
require 'china_unicom_api/models/netorder'
require 'china_unicom_api/models/comments'
require 'china_unicom_api/models/userstate'
require 'china_unicom_api/models/userpwd'

require 'china_unicom_api/models/netphonum'

require 'china_unicom_api/models/listcomment'
require 'china_unicom_api/models/commentlist'
require 'china_unicom_api/models/netbeijing'
require 'china_unicom_api/models/emailregister'
require 'china_unicom_api/models/maillogin'

require 'china_unicom_api/request_models/updateuserinfo'
require 'china_unicom_api/request_models/comments'
require 'china_unicom_api/request_models/login'


require 'china_unicom_api/ftp_parser/base'
require 'china_unicom_api/ftp_parser/app_req'
require 'china_unicom_api/ftp_parser/soft_req'
require 'china_unicom_api/ftp_parser/collection'
require 'china_unicom_api/ftp_parser/ftp_sync'

require 'china_unicom_api/jar3des'
require 'china_unicom_api/utils'

# directory = File.expand_path(File.dirname(__FILE__))
# puts ">>>>>>>>>>>>>>>>>>>#{directory}"
# require File.join(directory, 'china_unicom_api', 'request')
# require File.join(directory, 'china_unicom_api', 'parser')
# require File.join(directory, 'china_unicom_api', 'errors')
# require File.join(directory, 'china_unicom_api', 'custruct')
# require File.join(directory, 'china_unicom_api', 'collection')
# require File.join(directory, 'china_unicom_api', 'version')
# require File.join(directory, 'china_unicom_api', 'model.rb')

# require File.join(directory, 'china_unicom_api', 'models', 'Login')
# require File.join(directory, 'china_unicom_api', 'models', 'productlist')
# require File.join(directory, 'china_unicom_api', 'models', 'top')
 #puts ChinaUnicomApi::Getverifycode.rest_api
 #puts ChinaUnicomApi::CustomRest.rest_method('getverifycode').inspect
# #####
# login_str = File.read(File.dirname(__FILE__) + '/../test/fixtures/login_bin.txt')
# login_a=ChinaUnicomApi::Parser.convert(login_str)
# puts  login_a.inspect

#####
# category_str = File.read(File.dirname(__FILE__) + '/../test/fixtures/category_bin.txt')
# category_a   = ChinaUnicomApi::Parser.convert(category_str)
# puts category_a.inspect


# puts category_a.class
# puts category_a.current_page
# puts category_a.per_page
# puts category_a.total_entries
# puts category_a.size





# category_a.each_with_index do |x,jj|
#   puts "#{x['tablename']},#{x['rowcount']}"
#   x['columns'].each_with_index do |x1,i|
#       puts "#{jj}.#{i}: "+x1.keys.map {  |e| "#{e}=#{x1[e]}" }.join("|").to_s
#   end
#   puts ">>>>>>>>>>>>>>>>>>>>>>>>>\n\n"
# end

# #puts  category_a.hashdata.inspect
# response_baby="00000001000000056c6f67696e00000001000000100000000776657273696f6e0000000e616e64726f69645f76322e332e30000000000000000a757064617465666c61670000000100000000000000000375726c000000000000000000000004646573630000000fe4b88de99c80e8a681e58d87e7baa7000000000000000870686f6e656e756d0000000b31353535353231353535340000000000000008696e666f666c6167000000040000000000000000000000067561696e666f00000007416e64726f6964000000000000000275610000000a393030303030303030300000000000000008726d6d65736c656e00000004000001f4000000000000000973657373696f6e6964000000203863366661333033633066313462383338656531343235313664383264393932000000000000000a6d6573736d61786c656e00000004000000960000000000000008696e626f786d6178000000040000009600000000000000096f7574626f786d61780000000400000096000000000000000a6e657756657273696f6e0000000000000000000000076e657753697a650000000000000000000000076e6577446573630000000000000000";
# puts d.class.to_s
# puts d.columnconut
# puts d.inspect #["version"]





################################
# @request_header={
# 	"version"    =>"android_v2.3.0",
# 	"usertype"   =>"0",
# 	"settertype" =>"3",
# 	"preassemble"=>"Android-v2.0>Common>V2.3.0>20120717>NA>NA>NA>othersss>NA>NA",
# 	"phoneaccessmode"=> "3",
# 	"imsi"  =>"310260000000000",
# 	"imei"  =>"000000000000000",
# 	"handua"=>"9000000000",
# 	"handphone"           =>"15555215554",
# 	"x-up-calling-line-id"=>"15555215554",  #请求手机号码	Wap网关
# 	#请求手机类型	客户端
# 	"user-agent" =>"Mozilla/5.0 (Linux; U; Android 2.2; en-us; sdk Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
# 	"storeua"    =>"Mozilla/5.0 (Linux; U; Android 2.2; en-us; sdk Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
# 	"newclient"  =>"1"
# }

# maillogin = ChinaUnicomApi::Request.new("maillogin",{:loginmail=>'cgg5207@sina.com',:password=>'123456'},@request_header).invoke
# puts maillogin.inspect
# login     = ChinaUnicomApi::Request.new("login",{'password'=>'7ac66c0f148de9519b8bd264312c4d64'},@request_header).invoke
# puts login.inspect


#puts userinfo = ChinaUnicomApi::Request.new("userinfo",{},@request_header).invoke

# category_params={
# 	:category=>'top',
# 	:infoflag=>'3',
# 	:isshowapp=>'1',
# 	:ratio=>'2',
# 	:pagenum=>'1',
# 	:count=>'2'
# }

# category_a = ChinaUnicomApi::Request.new("category",category_params,@request_header).invoke
# puts category_a.inspect
# puts category_a.inspect
# puts category_a.class
# puts category_a.current_page
# puts category_a.per_page
# puts category_a.total_entries
# puts category_a.size

#puts recommend = ChinaUnicomApi::Request.new("recommend",{},@request_header).invoke

############################
