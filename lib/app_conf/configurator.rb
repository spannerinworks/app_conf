module AppConf
  class Configurator < BasicObject
    RESERVED_METHODS = %w(new ! != == __id__ __send__ equal? instance_eval instance_exec method_missing singleton_method_added singleton_method_removed singleton_method_undefined)
    
    def initialize(config_hash)
      @config = {}
      config_hash.each do |key, value|
        key_as_string = key.to_s
        ::Object.send(:raise, "'#{key_as_string}' is reserved.") if RESERVED_METHODS.include?(key_as_string)
        @config[key_as_string] = Configurator.extract_config_value(value)
      end
    end

    def self.extract_config_value(value)
      case value
        when ::Hash
          Configurator.new(value)
        when ::Array
          value.map { |val| extract_config_value(val) }
        else
          value
      end
    end

    def method_missing(name, *args)
      key = name.to_s
      if @config.has_key?(key)
        @config[key]
      else
        super
      end
    end

  end
end
