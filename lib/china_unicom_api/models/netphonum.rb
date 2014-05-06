require 'china_unicom_api/model'
module ChinaUnicomApi
  class Netphonum
    include Model
    field :result,    :type=>'int'
    field :desc,    :type=>'String'


    load_fields

  end
end