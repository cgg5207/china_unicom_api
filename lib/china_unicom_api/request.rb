require 'rubygems'
require 'httparty'


module ChinaUnicomApi
  class Request
    def initialize(api_name, options={},header_options={})
      options = options.clone
      @header_options = header_options.clone
      @header_options = @header_options.inject({}){|h,x| h.merge!({"#{x.first}"=>"#{x.last}"})} #rescue @header_options
      @api_name = api_name
      @params    = {}
      @endpoint  = ENV['CUAPI_ENDPOINT']
      # @headers={
      #   "x-up-calling-line-id"=>"",   #请求手机号码 Wap网关
      #   "user-agent"          =>"",   #请求手机类型 客户端
      #   "handphone"           =>"",   #用户输入手机号码，无则为空字符  客户端
      #   "handua"              =>"",   #用户选择的ua信息，无则为空字符 客户端
      #   "settertype"          =>"1",  #1、 设置类型所有机型 2、 显示适合指定机型的应用 3、显示适合本机型的应用  客户端
      #   "version"             =>"",   #客户端版本号 客户端
      #   "sessionid"           =>"",   #会话信息 客户端
      #   "imei"                =>"",   #手机IMEI号  客户端
      #   "imsi"                =>"",   #SIM卡 IMSI号 客户端
      #   "preassemble"         =>"",   #预装渠道号  客户端
      #   #"companylogo"        =>"",   #SNS请求来源渠道号（木瓜/人人）  客户端
      #   #"wostorestate"       =>"",     #状态码，详见状态码列表  服务端
      #   "newclient"           =>"1",    #1、新改版的客户端  客户端
      #   "phoneAccessMode"     =>"3",    #3：默认 31：3gwap 32:3Gnet 客户端
      #   "usertype"=>"0"                 #0:手机用户 1邮箱用户 3普通用户 客户端
      # }
     @headers={
      "usertype"=>"3",
      "phoneaccessmode"=> "3",
      "settertype" =>"3",
      "handphone"=>"00000000000",
      "handua"=>"",
      "newclient"  =>"1",
      "clientchannelflag"=>ENV['CUAPI_CLIENT_CHANNEL_FLAG']
     }
     @params.merge!(options)
     @headers.merge!(@header_options)
    end


    def invoke(method='get')
      if @api_name  =~/\?/
        url = ENV['CUAPI_ENDPOINT']+"/appstore_agent/NETPHONUM"+@api_name
      else
        url = endpoint_url(@api_name)
        @params_url = to_params(@params)
        unless @params_url.empty?
          url+= url=~/\?/ ? '&' : '?'
          url+="#{@params_url}" 
        end
      end

      Logging.skip_api_logging=false
      Logging.filter_ty_parameter_logging :fields => [:userPass,:userNewPwd,:userOldPwd,:userConfirmPwd]
      
      begin      
        Timeout::timeout(ENV['CUAPI_TIMEOUT'].to_i) do  
          Logging.log_ty_api(@api_name, @params,@headers) do   
            http_party_hash={}
            if method.downcase == 'post'
              url = endpoint_url(@api_name)
              @headers.merge!({'Content-Type'=>'application/octet-stream;charset=UTF-8', 'Accept' => 'application/octet-stream'})
              http_party_hash.merge!(:body=> parser_post(@api_name,@params) ,:headers=>@headers)
              http_party_hash.merge!(ChinaUnicomApi::Utils.proxy_hash)
              response = HTTParty.post(url,http_party_hash) 
            else
              http_party_hash.merge!(:headers=>@headers)
              http_party_hash.merge!(ChinaUnicomApi::Utils.proxy_hash)              
              response = HTTParty.get(url,http_party_hash) 
            end
            raise_errors(response)
          end
        end
      rescue Timeout::Error
        raise ChinaUnicomApi::Errors::ServerTimeOut.new
      end
    end

    def endpoint_url(api_method)
      ENV['CUAPI_ENDPOINT']+CustomRest.rest_method(api_method)
    end

    def parser_post(api_name,params)
      table_arr = [];rowsdata_arr=[];
      rowsdata_arr << params
      table_arr << {'tablename'=> "#{api_name}",'rowsdata'=>rowsdata_arr}              
      data = ChinaUnicomApi::Cuparser.convert(table_arr)      
    end


    def to_params(params)
      string = params.collect{|key,value| "#{key}=#{to_cgi(value)}"}.join("&")
      return string
    end   

    def to_cgi(val)
      CGI::escape(val) rescue val
    end


    def get_downdata(response)
      File.open("#{@api_name}.bin","wb")do |f|
        f.write response.body.unpack("H*")[0]
      end
    end


    def raise_errors(response)
      case response.code.to_i
        when 200..201
          #get_downdata(response)
          ChinaUnicomApi::Parser.convert(response)
        when 400   
          raise ChinaUnicomApi::Errors::BadRequest.new
        when 401
          raise ChinaUnicomApi::Errors::Unauthorized.new
        when 403
          raise ChinaUnicomApi::Errors::Forbidden.new
        when 413
          raise ChinaUnicomApi::Errors::RequestEntityTooLarge.new
        when 420  
          raise ChinaUnicomApi::Errors::NotFoundPhone.new
        when 421  
          raise ChinaUnicomApi::Errors::BlacklistNotlogin.new
        when 422  
          raise ChinaUnicomApi::Errors::UnprocessableEntity.new
        when 423  
          raise ChinaUnicomApi::Errors::Locked.new
        when 500  
          raise ChinaUnicomApi::Errors::InformServer.new
        when 503  
          raise ChinaUnicomApi::Errors::ServiceUnavailable.new
      end
    end

  end
end








