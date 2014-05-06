require 'china_unicom_api/model'
module ChinaUnicomApi
  class Commentlist
    include Model
    field :id,    :type=>'String'
    field :comment,    :type=>'String'
    field :date,    :type=>'long'
    field :username,    :type=>'String'
    field :userstar,    :type=>'Int'

    load_fields

  end
end