require 'rubygems'
require 'httparty'
require 'active_support' 
require 'active_support/core_ext/hash'

module ChinaUnicomApi
  class WebRequest

    #0.道具计费点接口
    def self.evaluate_query_appc_charging_points(cnt_index)
      return new("/cntportal/evaluate_queryAppcChargingPoints.action?cntIndex=#{cnt_index}").invoke
    end

    #1.草稿箱里在线应用查询请求
    def self.evaluate_query_devleper_online_apps(devid)
      return new("/cntportal/evaluate_queryDevleperOnlineApps.action?devId=#{devid}").invoke
    end

    #2. 评价查询请求
    def self.evaluate_query_user_evaluate(usercode,productindex)
      #/cntportal/evaluate_queryUserEvaluate.action?usercode=18616736462&productindex=30553
      return new("/cntportal/evaluate_queryUserEvaluate.action?usercode=#{usercode}&productindex=#{productindex}").invoke
    end


    #3.评价请求
    def self.evaluate_insert_dev_evaluate(usercode,productindex,description)
      #/cntportal/evaluate_insertDevEvaluate.action?description=18616736462&recordtime=20121019093819&productindex=136452&usercode=18616736462
      return new("/cntportal/evaluate_insertDevEvaluate.action",
        { 'productindex'=>productindex,
          'usercode'    =>usercode,
          'description' =>description,
          'recordtime'  =>Time.now.strftime("%Y%m%d%H%M%S")} ).invoke('post')
    end

    #3.评价请求
    def self.evaluate_insert_dev_evaluate_get(usercode,productindex,description)
      #/cntportal/evaluate_insertDevEvaluate.action?description=18616736462&recordtime=20121019093819&productindex=136452&usercode=18616736462
      return new("/cntportal/evaluate_insertDevEvaluate.action?"+
         "productindex=#{productindex}"+
         "&usercode=#{usercode}"+
         "&description=#{description}"+
         "&recordtime=#{Time.now.strftime("%Y%m%d%H%M%S")}" ).invoke('post')
    end


    def initialize(api_name, options={},header_options={})
      options = options.clone
      @header_options = header_options.clone
      @api_name = api_name
      @params    = {}
      @headers   = {}
      @endpoint  = ENV['CUAPI_WEB_ENDPOINT']
      @params.merge!(options)
      @headers.merge!(header_options)
    end


    def invoke(method='get')
      begin      
        Timeout::timeout(ENV['CUAPI_TIMEOUT'].to_i) do  
          Logging.log_ty_api(@api_name, @params,@headers) do   
            http_party_hash={}
            http_party_hash.merge!(ChinaUnicomApi::Utils.proxy_hash)
            url = endpoint_url(@api_name)
            #todo change send method
            if method.downcase == 'post' 
              http_party_hash.merge!(:body=> @params ,:headers=>@headers)
              response = HTTParty.post(url,http_party_hash) 
            else
              http_party_hash.merge!(:body=> @params ,:headers=>@headers)
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
      @endpoint+@api_name
    end


    def parse(response)
      #puts response.body.inspect
      decode64_xml  = ChinaUnicomApi::Jar3des.decrypt(ENV['CUAPI_3DEC_KEY'],
        Base64.encode64(response.body).gsub("\n",'')
        )
      Hash.from_xml(Base64.decode64(decode64_xml))
    rescue
      raise '解析出错'
    end


    def parse_xml2hash(response)
      parse(response)
    end


    def raise_errors(response)
      case response.code.to_i
        when 200..201
          parse_xml2hash(response)
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








