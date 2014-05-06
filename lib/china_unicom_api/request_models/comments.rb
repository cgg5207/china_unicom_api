require 'china_unicom_api/model'
module ChinaUnicomApi
  module RequestModels	
	class Comments
	  include Model

	    field :productid,  :type=>'String'
	    field :comments,  :type=>'String'
	    field :rate,  :type=>'int'
		load_fields

	end
  end
end