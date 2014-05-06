module ChinaUnicomApi
  module Errors

		class RestReport< RuntimeError
			attr_accessor :innercode, :message, :code
			def initialize(response)
			  @code = response['code']
			  @innercode = response['innercode']
			  @message = response['message']
			end

			def to_s
				case @code
				when '0000' then return '成功'
				when '0001' then return '必填参数未填'
				when '0002' then return '参数格式不正确'
				when '9000' then return '数据库操作失败'
				when '1003' then return '用户不存在'
				end
		  end
		end  	


		class CuReport< RuntimeError
	    def initialize(reason)
	      @reason = reason
	    end			
			def to_s
			  @reason
			end
		end  	

		class Parser< RuntimeError
		  def to_s
		  	'解析出错'
		  end
		end  	

		class ServerTimeOut< RuntimeError
	    def to_s
	      "请求服务器超时"
	    end
	  end  	

		# 400	客户端请求无效
		class BadRequest< RuntimeError
			def http_code
			  400
			end
	    def to_s
	      "客户端身份验证错误"
	    end
	  end  		


		# 401	客户端身份验证错误
		class Unauthorized< RuntimeError
			def http_code
			  401
			end			
	    def to_s
	      "客户端身份验证错误"
	    end
	  end  		

		# 403	服务器拒绝处理请求
		class Forbidden< RuntimeError
			def http_code
			  403
			end					
	    def to_s
	      "服务器拒绝处理请求"
	    end
	  end  		


		# 413	请求消息太大
		class RequestEntityTooLarge< RuntimeError
			def http_code
			  413
			end						
	    def to_s
	      "请求消息太大"
	    end
	  end  		


		# 420	获取不到手机号，需要用户输入手机号和密码重新登录
		class NotFoundPhone< RuntimeError
			def http_code
			  420
			end					
	    def to_s
	      "获取不到手机号，需要用户输入手机号和密码重新登录"
	    end
	  end  		

		# 421	用户是黑名单用户，无法登录
		class BlacklistNotlogin< RuntimeError
			def http_code
			  421
			end						
	    def to_s
	      "用户是黑名单用户，无法登录"
	    end
	  end  	


		# 422	用户密码错误，无法登录
		class UnprocessableEntity< RuntimeError
			def http_code
			  422
			end					
	    def to_s
	      "用户密码错误，无法登录"
	    end
	  end  	


		# 423	sessionid验证错误，用户非法访问，客户端返回登录界面
	  class Locked < RuntimeError
			def http_code
			  423
			end			  	
	    def to_s
	      "sessionid验证错误，用户非法访问，客户端返回登录界面"
	    end
	  end  	


   	  # 500	服务器内部错误，无法完成请求
	  class InformServer < RuntimeError
			def http_code
			  500
			end				  	
	    def to_s
	      "服务器内部错误，无法完成请求"
	    end
	  end  	

	  # 503	服务器暂时无法可用
	  class ServiceUnavailable < RuntimeError
			def http_code
			  503
			end				  	
	    def to_s
	      "服务器暂时无法可用"
	    end
	  end  		  

  end
end  