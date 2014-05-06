module ChinaUnicomApi
  module FtpParser	
		class SoftReq
		  def self.app_fields
				{
					1=>'productid',
					2=>'size',
					3=>'version',
					4=>'packagename',
					5=>'downloadurl',
					6=>'os',
					7=>'handsetid',
					8=>'sourcetype'
				}
		  end


		  attr_accessor *app_fields.values

		end
  end
end