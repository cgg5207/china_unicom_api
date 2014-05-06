module ChinaUnicomApi
  class Jar3des
    class << self
      # 此加密与解密为java版3DES
      # 发送和接受的数据均采用UTF-8格式
      # 实时接口加密方式：使用3DES加密
      # 实时接口压缩方式：inflate
      # 实时接口加密规则：inflate(3DES(明文))
      # 用base64与java通讯不会有字符集的问题。
      def tdes_jar_path
        if defined? RAILS_ENV
          "#{RAILS_ROOT}/vendor/plugins/china_unicom_api/bin/"
        else
          File.dirname(__FILE__) + "/../../bin/"
        end
      end
      
      #解密
      def decrypt(key,data)
        `java -jar #{tdes_jar_path}RubyUtil.jar decompress '#{key}' '#{data}'`
      end
      
      #加密
      def encrypt(key,data)
        `java -jar #{tdes_jar_path}RubyUtil.jar compress '#{key}' '#{data}'`
      end
    end

  end
end