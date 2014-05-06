module ChinaUnicomApi
  module FtpParser	
		class AppReq
		  def self.app_fields
				{
					1=>'optype',
					2=>'productid',
					3=>'name',
					4=>'iconurl',
					5=>'rate',
					6=>'rate_count',
					7=>'price',
					8=>'supplier',
					9=>'desc',
					10=>'tag',
					11=>'dlcount',
					12=>'category',
					13=>'iconurl1',
					14=>'iconurl2',
					15=>'iconurl3',
					16=>'iconurl4',
					17=>'publishtime',
					18=>'language',
					19=>'sourcetype'
				}
		  end


		  attr_accessor *app_fields.values

		end
  end
end