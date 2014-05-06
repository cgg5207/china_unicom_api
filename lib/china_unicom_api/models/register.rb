require 'china_unicom_api/model'
module ChinaUnicomApi
  class Register
    include Model
    
    field :result,  :type=>'int'
    field :desc,    :type=>'String'

    field :version,    :type=>'String'
    field :updateflag,    :type=>'byte'
    field :url,    :type=>'String'
    field :desc,    :type=>'String'
    field :rmmeslen,    :type=>'int'
    field :infoflag,    :type=>'Int'
    field :uainfo,    :type=>'String'
    field :ua,    :type=>'String'
    field :sessionid,    :type=>'String'
    field :newVersion,    :type=>'String'
    field :newSize,    :type=>'String'
    field :newDesc,    :type=>'String'

    load_fields

    def self.this_instance_return_boolean
      true
    end
        
  end
end