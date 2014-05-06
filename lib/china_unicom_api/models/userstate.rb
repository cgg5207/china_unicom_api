require 'china_unicom_api/model'
module ChinaUnicomApi
  class Userstate
    include Model

    field :result,  :type=>'int'
    field :desc,    :type=>'String'

    load_fields

    def self.this_instance_return_boolean
      true
    end
    
  end
end