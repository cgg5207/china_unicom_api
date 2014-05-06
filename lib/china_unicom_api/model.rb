module ChinaUnicomApi
  module Model
    def self.included(klass)
      klass.instance_variable_set('@fields', {})
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end



    module ClassMethods
      def field(*args)
        @fields[args.first] = args.last[:type]||="String"
      end


      def type_value(type='String',value=nil)
        type = type.downcase
        type = (type=='byte' ? 'string' : type)
        case type
        when 'string'
          return value.to_s
        when 'int'
          return value.to_i
        end
      end
    
      
      def load_fields
        @fields.each do |field_key,field_attr|
          define_method("#{field_key}=") do |value|
            instance_variable_set "@#{field_key}", self.class.type_value(field_attr,value)
          end
          
          ##How to initialize 'attr_accessor' attribute values?
          ##http://stackoverflow.com/questions/7081477/how-to-initialize-attr-accessor-attribute-values
          define_method("#{field_key}") do
            instance_variable_get("@#{field_key}") ||
                (instance_variable_set  "@#{field_key}", self.class.type_value(field_attr) )
          end     
        end        
      end    


      def ctype(field=nil)
        instance_variable_get('@fields').find{|x|x[0]==field.to_sym }.last.downcase
      rescue
        nil
      end


      def this_instance_return_boolean
        false
      end      
    end


      
    module InstanceMethods
      
    end
      
  end
end
