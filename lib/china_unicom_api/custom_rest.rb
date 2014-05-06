module ChinaUnicomApi
  module CustomRest


		def self.rest_method(api_method)
			all_resturl.find{|x,v|x==api_method.downcase}[1]
		rescue
			"#{default_resturl}#{api_method}"
		end	  


		def self.default_resturl
			"/appstore_agent/unistore/servicedata.do?serviceid="
		end


		def self.all_resturl
			hash={}
			hash['getverifycode'] = "/appstore_agent/getverifycode.do"
			hash['getpassword']   = "/appstore_agent/getpassword.do"
			hash['axon_key']      = "/appstore_agent/NETPHONUM?params=Axon_key"
			hash['axon_key_back'] = "/appstore_agent/NETPHONUM"
			return hash
		end

	end
end  