# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'china_unicom_api/version'

spec = Gem::Specification.new do |s|
  s.name = 'china-unicom-api'
  s.version = ChinaUnicomApi::VERSION
  s.summary = "china unicom api"
  s.description = %{china unicom api.}
  s.files = Dir.glob("{lib}/**/*") + %w(README.md)  
  s.require_path = 'lib'
  s.rubyforge_project = 'china-unicom-api'
  s.author = "john chen"
  s.email = "cgg5207@gmail.com"
  s.homepage = "http://github.com/cgg5207/china_unicom_api"
end
