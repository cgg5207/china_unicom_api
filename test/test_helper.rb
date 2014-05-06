require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )

require 'china_unicom_api'
#require File.dirname(__FILE__)+'/../lib/china_unicom_api.rb'




def load_file_bin(filename)
	File.read(File.dirname(__FILE__) + "/../test/fixtures/#{filename}") #.unpack("H*")[0]
end







