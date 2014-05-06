require 'china_unicom_api/model'
module ChinaUnicomApi
  class Netorder
    include Model

    field :result,  :type=>'int'
    field :desc,    :type=>'String'
    field :downurl,    :type=>'String'
    load_fields

    # def self.this_instance_return_boolean
    #   true
    # end
    
  end
end