require 'benchmark'
module ChinaUnicomApi
  @@logger = nil
  def self.logger=(logger)
    @@logger = logger
  end
  def self.logger
    @@logger
  end

  module Logging
    @skip_api_logging = nil
    @filter_parameters={}
    class << self
      attr_accessor :skip_api_logging 
      attr_accessor :filter_parameters
    end

    def self.filter_ty_parameter_logging(options = [])      
      # write_inheritable_attribute(:filter_ty_logging, {
      #                             :fields => (options[:fields] || []) 
      #                             })
      # class_inheritable_reader :filter_ty_logging
      @filter_parameters = options[:fields].map{|x|x.to_s}
    end


    def self.log_ty_api(method, params,heads)
      message = method # might customize later
      dump = format_ty_params(params)
      heads = format_ty_params(heads)
      if block_given?
        result = nil
        seconds = Benchmark.realtime { result = yield }
        log_info(message, dump, heads, seconds) unless skip_api_logging
        result
      else
        log_info(message, dump, heads) unless skip_api_logging
        nil
      end
    rescue Exception => e
      exception = "#{e.class.name}: #{e.message}"
      log_info(message, dump, heads,0,exception)
      raise
    end

    def self.format_ty_params(params)
      params.map { |key,value|  
        if  @filter_parameters.include?key
          "'#{key}'=>[FILTERED]"
        else
          if value.class.to_s=='Fixnum'
            "'#{key}'=>#{value}"
          else
            "'#{key}'=>'#{value}'"
          end
        end
      }.join(', ')
    end

    def self.log_info(message, dump, heads ,seconds = 0,exception=nil)
      return unless ChinaUnicomApi.logger
      exception = exception.nil? ? '' : "exception:{ #{exception} }\n" 
      log_message = "\n\n"
      log_message +="Processing ChinaUnicomApi_Api method:#{message} (at #{Time.now.strftime('%y-%m-%d %H:%M:%S')} )\n"
      log_message +="Parameters:{ #{dump} } \n" unless dump.empty?
      log_message +="Headers:{ #{heads} } \n"   unless heads.empty?
      log_message +="#{exception}"
      log_message +="Completed in (#{seconds}) "

      ChinaUnicomApi.logger.info(log_message)
    end
    
  end  
end