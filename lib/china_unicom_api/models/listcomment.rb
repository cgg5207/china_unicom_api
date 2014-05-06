require 'china_unicom_api/model'
module ChinaUnicomApi
  class Listcomment
    include Model
    field :totalrows,     :type=>'int'
    field :pagenum,       :type=>'Int'
    field :returnrows,    :type=>'Int'
    load_fields

  end
end