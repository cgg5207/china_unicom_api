require 'china_unicom_api/model'
module ChinaUnicomApi
  class Userinfo
    include Model

    field :name,    :type=>'String'
    field :gender,    :type=>'int'
    field :nick,    :type=>'String'
    field :age,    :type=>'int'
    field :mail,    :type=>'String'
    field :phone,    :type=>'String'
    field :idcard,    :type=>'String'
    field :devicetype,    :type=>'String'
    field :devicetypeid,    :type=>'String'
    field :score,    :type=>'int'
    field :userlevel,    :type=>'String'
    field :woaccount,    :type=>'String'
    field :woaccstate,    :type=>'int'
    field :woaccbalance ,    :type=>'String'
    field :woaccinfo,    :type=>'String'
    field :hideinfo,    :type=>'Byte'
    field :phonesearch,    :type=>'byte'
    field :addtofriend,    :type=>'byte'
    field :verification,    :type=>'byte'
    field :receivedevinfo,    :type=>'byte'
    field :receivedfriend,    :type=>'byte'
    field :receivedstrange,    :type=>'byte'
    field :receivedsystem,    :type=>'byte'
    field :wobean,    :type=>'String'
    field :growth,    :type=>'int'
    load_fields

  end
end