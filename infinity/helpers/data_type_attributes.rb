# Adds attributes to a class to help parse stuff faster
# * Call the method in the order that the file is formated
# 

module Infinity
  module DataTypes
    INT_TYPES = %w(unsigned_64 unsigned_32 unsigned_16 unsigned_8 signed_64 signed_32 signed_16 signed_8)
    attr_accessor :data_structure
    
    INT_TYPES.each do |type_name|
      type, size = type_name.split('_')
      # converts bits to bytes
      bytes = size.to_i/8
      
      eval("def attr_#{type_name}_int(name)
        add_to_structure(:#{type_name}_int, name, #{bytes})
      end")
    end
    
    def attr_string(name, options={:length => 2})
      add_to_structure(:string, name, options[:length])
    end

    def attr_hex(name, options={:length => 4})
      add_to_structure(:hex, name, options[:length])
    end
    
    def attr_binary(name, options={:length=>4})
      add_to_structure(:binary, name, options[:length])
    end
    
    private
    def add_to_structure(type, name, length)
      @data_structure ||= []
      @data_structure << {:type => type.to_s, :name => name, :length => length}
      attr_accessor(name.to_sym)
    end
    
  end # class
end