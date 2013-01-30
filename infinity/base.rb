module Infinity
  class Base
    extend Infinity::DataTypes
    
    attr_accessor :raw_data
    
    class <<self
      def create_from_data(data, offset = 0, length = -1)
        new_base = new
        new_base.raw_data = data.byteslice(offset, length)
        new_base.extract_bytes!
        new_base
      end
    end # class <<self
    
    def attr_name(type, name)
      self.class.attr_name(type, name)
    end

    def set_infinity_attr(type, name, value)
      self.class.set_infinity_attr(type, name, value)
    end

    def get_infinity_attr(type, name)
      self.class.get_infinity_attr(type, name)
    end
    
    def get_offseted_data(offset, length)
      self.raw_data.byteslice(offset, length)
    end
    
    def extract_bytes!
      offset = 0
      self.class.data_structure.each do |data_target|
        if data_target[:type] === "string"
          puts "trying to rip string from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.class.set_infinity_attr(data_target[:type], data_target[:name], extract_string(self.raw_data, offset, data_target[:length], data_target[:no_strip]))
        elsif data_target[:type] =~ /^unsigned_[0-9]+_int$/
          puts "trying to rip unsigned from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.class.set_infinity_attr(data_target[:type], data_target[:name], extract_unsigned_int(self.raw_data, offset, data_target[:length]))
        elsif data_target[:type] =~ /^signed_[0-9]+_int$/
          puts "trying to rip signed from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.class.set_infinity_attr(data_target[:type], data_target[:name], extract_signed_int(self.raw_data, offset, data_target[:length]))
        elsif data_target[:type] == "binary"
          puts "trying to rip binary from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.class.set_infinity_attr(data_target[:type], data_target[:name], extract_binary(self.raw_data, offset, data_target[:length]))
        else
          raise "unhandled type '#{data_target[:type]}'! \n\t #{data_target.inspect}"
        end
        offset += data_target[:length]
      end
    end
    
    def extract_string(data, offset, length, strip = true)
      result = data.byteslice(offset, length)
      if strip
        result.strip
      else
        result
      end
    end
    
    def extract_binary(data, offset, bytes)
      bits = bytes*8
      data.byteslice(offset,bytes).unpack("B#{bits}").first
    end

    def extract_hex(data, offset, length)
      data.byteslice(offset, length).unpack("H#{length}").first
    end
    
    def extract_signed_int(data, offset, length)
      # Note: not sure if I should be using big or little endian, so I'm using native here 
      if length == 1
        data.byteslice(offset, length).unpack('c').first
      elsif length == 2
        data.byteslice(offset, length).unpack("s").first
      elsif length == 4
        data.byteslice(offset, length).unpack("l").first
      elsif length == 8
        data.byteslice(offset, length).unpack("q").first
      else
        data.byteslice(offset, length).unpack("c").first
      end
    end
    
    def extract_unsigned_int(data, offset, length)
      # Note: not sure, I'm assuming native endian
      if length == 1
        data.byteslice(offset, length).unpack('C').first
      elsif length == 2
        data.byteslice(offset, length).unpack("S").first
      elsif length == 4
        data.byteslice(offset, length).unpack("L").first
      elsif length == 8
        data.byteslice(offset, length).unpack("Q").first
      else
        data.byteslice(offset, length).unpack("C").first
      end
    end
    
    def write_to_file(path)
      File.open(path, 'wb') do |file|
        file.write(data_string)
      end
    end
    
    def data_dump
      data_string = ""
      
      self.class.data_structure.each do |data_target|
        if data_target[:type] === "string"
          data_string += print_string(self.class.get_infinity_attr(data_target[:type], data_target[:name]), data_target[:length])
        elsif data_target[:type] =~ /^unsigned_[0-9]+_int$/
          data_string += print_unsigned_int(self.class.get_infinity_attr(data_target[:type], data_target[:name]), data_target[:length])
        elsif data_target[:type] =~ /^signed_[0-9]+_int$/
          data_string += print_signed_int(self.class.get_infinity_attr(data_target[:type], data_target[:name]), data_target[:length])
        elsif data_target[:type] == "binary"
          data_string += print_binary(self.class.get_infinity_attr(data_target[:type], data_target[:name]), data_target[:length])
        else
          raise "unhandled type '#{data_target[:type]}'! \n\t #{data_target.inspect}"
        end
      end
      
      data_string
    end
    
    
    def print_string(string, max_length)
      string[0...max_length].ljust(max_length,"\x00")
    end
    
    def print_unsigned_int(number, length)
      if length == 2
        Array(number).pack('S')
      elsif length == 4
        Array(number).pack('L')
      elsif length == 8
        Array(number).pack('Q')
      else
        Array(number).pack('C')
      end
    end

    def print_signed_int(number, length)
      if length == 2
        Array(number).pack('s')
      elsif length == 4
        Array(number).pack('l')
      elsif length == 8
        Array(number).pack('q')
      else
        Array(number).pack('c')
      end
    end
    
    def print_binary(number, length)
      bits = length*8
      Array(number).pack("B#{bits}")
    end
    
  end
end