# Include hook code here
china_unicom_api_config = "#{RAILS_ROOT}/config/china_unicom_api.yml"
require 'china_unicom_api'

china_unicom_api = ChinaUnicomApi.load_configuration(china_unicom_api_config)

ChinaUnicomApi.logger = RAILS_DEFAULT_LOGGER if Object.const_defined? :RAILS_DEFAULT_LOGGER