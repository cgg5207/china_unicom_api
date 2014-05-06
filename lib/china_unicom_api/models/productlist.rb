require 'china_unicom_api/model'
module ChinaUnicomApi
  class Productlist
    include Model

    field :id,     :type=>'String'
    field :name,   :type=>'String'
    field :icon,   :type=>'String'
    field :rate,   :type=>'int'
    field :price ,     :type=>'int'
    field :supplier,   :type=>'String'
    field :catagory,   :type=>'String'
    field :ispromotion,   :type=>'int'
    field :promprice,     :type=>'Int'
    field :promotionstart,:type=>'String'
    field :promotionend,  :type=>'String'
    field :size,   :type=>'Int'
    field :sizeinfo,      :type=>'String'
    field :nosiziinfo,    :type=>'String'
    field :packageName,   :type=>'String'
    field :versionName,   :type=>'String'
    field :ismoresoft,    :type=>'Int'
    load_fields

  end
end