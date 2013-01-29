module Infinity
  class Base
    extend Infinity::DataTypes
    
    attr_accessor :raw_data
    
    class <<self
      
    end # class <<self
    
    def extract_bytes!
      offset = 0
      self.class.data_structure.each do |data_target|
        if data_target[:type] === "string"
          puts "trying to rip string from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.send("#{data_target[:name]}=", extract_string(self.raw_data, offset, data_target[:length], data_target[:no_strip]))
        elsif data_target[:type] =~ /^unsigned_[0-9]+_int$/
          puts "trying to rip unsigned from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.send("#{data_target[:name]}=", extract_unsigned_int(self.raw_data, offset, data_target[:length]))
        elsif data_target[:type] =~ /^signed_[0-9]+_int$/
          puts "trying to rip signed from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.send("#{data_target[:name]}=", extract_signed_int(self.raw_data, offset, data_target[:length]))
        elsif data_target[:type] == "binary"
          puts "trying to rip binary from #{offset} to #{data_target[:length]} For #{data_target[:name]}"
          self.send("#{data_target[:name]}=", extract_binary(self.raw_data, offset, data_target[:length]))
        else
          raise "unknown handled '#{data_target[:type]}'! \n\t #{data_target.inspect}"
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
  end
end