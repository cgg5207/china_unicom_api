require 'fileutils'
require 'rubygems'

dir = File.dirname(__FILE__)
templates = File.join(dir, 'generators', 'china_unicom_api', 'templates')
config = File.join('config', 'china_unicom_api.yml')

[config].each do |path| 
  FileUtils.cp File.join(templates, path), File.join(RAILS_ROOT, path) unless File.exist?(File.join(RAILS_ROOT, path))
end