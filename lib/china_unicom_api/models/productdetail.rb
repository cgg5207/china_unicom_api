require 'china_unicom_api/model'
module ChinaUnicomApi
  class Productdetail
    include Model

    field :id,    :type=>'String'
    field :name,    :type=>'String'
    field :icon,    :type=>'String'
    field :rate,    :type=>'int'
    field :price,    :type=>'int'
    field :supplier,    :type=>'String'
    field :desc,    :type=>'String'
    field :type,    :type=>'int'
    field :appid,    :type=>'String'
    field :iscommend,    :type=>'byte'
    field :size,    :type=>'int'
    field :dlcount,    :type=>'int'
    field :catagory,    :type=>'String'
    field :screenshots1,    :type=>'String'
    field :screenshots2,    :type=>'String'
    field :screenshots3,    :type=>'String'
    field :screenshots4,    :type=>'String'
    field :priceinfo,    :type=>'String'
    field :sizeinfo,    :type=>'String'
    field :nosiziinfo,    :type=>'String'
    field :isfree,    :type=>'int'
    field :free,    :type=>'String'
    field :ispromotion,    :type=>'int'
    field :promprice,    :type=>'String'
    field :donoteisfree,    :type=>'Int'
    field :promotionstart,    :type=>'String'
    field :promotionend,    :type=>'String'
    field :versioncode,    :type=>'String'
    field :favoriteflag,    :type=>'Int'
    field :appdate,    :type=>'String'
    field :updatetime,    :type=>'String'
    field :packageName,    :type=>'String'
    field :versionName,    :type=>'String'
    field :ismoresoft,     :type=>'int'
    field :isvaccharge,    :type=>'int'











    load_fields

  end
end