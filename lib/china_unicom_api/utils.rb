module ChinaUnicomApi
  class Utils
  	class << self

	    def proxy_hash
	      if to_bool(ENV['CUAPI_HTTP_PROXY'])
	        proxy_config={:http_proxyaddr=>ENV['CUAPI_HTTP_PROXYADDR'],:http_proxyport=>ENV['CUAPI_HTTP_PROXYPORT']}
	      else
	        proxy_config={}
	      end      
	    end

	    #Parse a String to a Boolean in Ruby on Rails
	    #http://jeffgardner.org/2011/08/04/rails-string-to-boolean-method/
	    def to_bool(str)
	      return true if str == true || str =~ (/(true|t|yes|y|1)$/i)
	      return false if str == false || str.blank? || str =~ (/(false|f|no|n|0)$/i)
	      raise ArgumentError.new("invalid value for Boolean: \"#{str}\"")
	    end      	  

  	end
  end
end  

