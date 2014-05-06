require 'rubygems'
require 'httparty'
require 'json'
require 'crack'

module ChinaUnicomApi
  class RestRequest

    def self.addwodou(userid,options={},header_options={})
      params={'userid'=>userid,'snsid'=> userid}
      params.merge!(options)
      return new("/rest/manager/wodou/addwodou/#{ENV['CUAPI_SNS_SOURCE']}/#{ENV['CUAPI_SNS_AUTHCODE']}?userid=#{userid}", 
        params,
        header_options
        ).invoke
    end

    def self.addgrowth(userid,options={},header_options={})
      params={'userid'=>userid,'snsid'=> userid}
      params.merge!(options)
      return new("/rest/manager/growup/addgrowth/#{ENV['CUAPI_SNS_SOURCE']}/#{ENV['CUAPI_SNS_AUTHCODE']}?userid=#{userid}",
       params,
       header_options
       ).invoke
    end

    
    def initialize(api_name, options={},header_options={})
      options = options.clone
      @header_options = header_options.clone
      @api_name = api_name
      @params    = {
        'opertime' => Time.now.strftime("%Y%m%d%H%M%S"),
        'channelid'=> ENV['CUAPI_CHANNELID']
      }
      @endpoint  = ENV['CUAPI_SNS_ENDPOINT']
      @params.merge!(options)
      @headers={'Content-Type'=>'application/json','Accept' =>'application/json'}
      @headers.merge!(header_options)
    end


    def invoke
      begin      
        Timeout::timeout(ENV['CUAPI_TIMEOUT'].to_i) do  
          Logging.log_ty_api(@api_name, @params,@headers) do   
            http_party_hash={}
            url = endpoint_url(@api_name)
            http_party_hash.merge!(:body=> @params.to_json ,:headers=>@headers)
            http_party_hash.merge!(ChinaUnicomApi::Utils.proxy_hash)
            response = HTTParty.post(url,http_party_hash) 
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
      Crack::JSON.parse(response.body)
    end    

    def exceptions_format(response)
      return response if response['code']=='0000'
      raise ChinaUnicomApi::Errors::RestReport.new(response)
    end    

    def raise_errors(response)
      case response.code.to_i
        when 200..201
          exceptions_format(parse(response))
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








