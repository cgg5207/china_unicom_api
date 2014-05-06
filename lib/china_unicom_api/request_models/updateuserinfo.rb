require 'china_unicom_api/model'
module ChinaUnicomApi
  module RequestModels	
	class Updateuserinfo
	  include Model

	    field :name	,  :type=>'String'
	    field :gender,  :type=>'int'
	    field :nick,  :type=>'String'
	    field :age,  :type=>'int'
	    field :mail,  :type=>'String'
	    field :idcard,  :type=>'String'
	    field :devicetypeid,  :type=>'String'
	    field :hideinfo,  :type=>'Byte'
	    field :phonesearch,  :type=>'byte'
	    field :addtofriend,  :type=>'byte'
	    field :verification,  :type=>'byte'
	    field :receivedevinfo,  :type=>'byte'
	    field :receivedfriend,  :type=>'byte'
	    field :receivedstrange,  :type=>'byte'
	    field :receivedsystem,  :type=>'byte'
		load_fields

	end
  end
end