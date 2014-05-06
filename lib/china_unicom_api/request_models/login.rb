require 'china_unicom_api/model'
module ChinaUnicomApi
  module RequestModels	
	class Login
	  include Model

	    field :phonenum,  :type=>'String'
	    field :version,  :type=>'String'
	    field :updateflag,  :type=>'byte'
	    field :url,  :type=>'String'
	    field :desc,  :type=>'String'
	    field :rmmeslen,  :type=>'int'
	    field :infoflag,  :type=>'Int'
	    field :uainfo,  :type=>'String'
	    field :ua,  :type=>'String'
	    field :sessionid,  :type=>'String'
	    field :messmaxlen,  :type=>'int'
	    field :inboxmax,  :type=>'Int'
	    field :outboxmax,  :type=>'Int'
	    field :newVersion,  :type=>'String'
	    field :newSize,  :type=>'String'
	    field :newDesc,  :type=>'String'



		load_fields

	end
  end
end