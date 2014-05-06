require 'china_unicom_api/model'
module ChinaUnicomApi
  class Top
    include Model

    field :totalrows,   :type=>'int'
    field :pagenum,     :type=>'int'
    field :returnrows,  :type=>'int'
    load_fields

  end
end