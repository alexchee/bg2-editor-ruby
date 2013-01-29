# Based off of info from here:
# http://iesdp.gibberlings3.net/file_formats/ie_formats/chr_v2.htm#CHRV2_0_CHR_Header

module Infinity 
  class CharacterData < Infinity::Base
    attr_accessor :signature # 4 bytes
    attr_accessor :version # 4 bytes
    attr_accessor :character_name # 32 bytes
    attr_accessor :character_data_offset # Integer (32 bits) - 4 bytes
    attr_accessor :character_data_length # Integer (32 bits) - 4 bytes
  	attr_accessor :quick_weapon_1_index # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_weapon_2_index # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_weapon_3_index # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_weapon_4_index # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_weapon_1 # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_weapon_2 # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_weapon_3 # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_weapon_4 # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_spell_1_resource # 8 bytes
  	attr_accessor :quick_spell_2_resource # 8 bytes
  	attr_accessor :quick_spell_3_resource # 8 bytes
  	attr_accessor :quick_item_1_index # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_item_2_index # Integer (16 bits) - 2 bytes
  	attr_accessor :quick_item_3_index # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_item_1 # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_item_2 # Integer (16 bits) - 2 bytes
  	attr_accessor :show_quick_item_3 # Integer (16 bits) - 2 bytes
    attr_accessor :creature_data

    def self.load_file(file)
    	if (file=File.open(file,'r'))
    	  char_data = self.new()
    	  data = file.read

        offset = 0
        char_data.signature = data.byteslice(0,chunk=4)
        char_data.version = data.byteslice(offset+=chunk,chunk=4) # should be "v2.0" 
        char_data.character_name = data.byteslice(offset+=chunk,chunk=32).strip
        char_data.character_data_offset = data.byteslice(offset+=chunk,chunk=4).unpack('V').first
        char_data.character_data_length = data.byteslice(offset+=chunk,chunk=4).unpack('V').first
        # Quick Weapon slots - stores index of weapon
        # Disabled is 0xff or 65535
        char_data.quick_weapon_1_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_weapon_2_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_weapon_3_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_weapon_4_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        # Show quick weapon slot toggle
        # Show Slot = 0x00 or 0
        # Hide Slot = 0xFF or 65535
        char_data.show_quick_weapon_1 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.show_quick_weapon_2 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.show_quick_weapon_3 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.show_quick_weapon_4 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_spell_1_resource = data.byteslice(offset+=chunk,chunk=8)
        char_data.quick_spell_2_resource = data.byteslice(offset+=chunk,chunk=8)
        char_data.quick_spell_3_resource = data.byteslice(offset+=chunk,chunk=8)
        # Quick Item slots - stores index of item
        char_data.quick_item_1_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_item_2_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.quick_item_3_index = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        # Show quick item slot toggle
        # Show Slot = 0x00 or 0
        # Hide Slot = 0xFF or 65535
        char_data.show_quick_item_1 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.show_quick_item_2 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.show_quick_item_3 = data.byteslice(offset+=chunk,chunk=2).unpack('v').first
        char_data.creature_data = Infinity::CreatureData.load_data(data.byteslice(@character_data_offset, @character_data_length))
        # Could cheat and just go to end
        # char_data.creature_data = data.byteslice(@character_data_offset..-1)

    	  char_data
  	  else
  	    raise "Error cannot open file"
      end
    end

    def write_to_file(path)
      File.open(path, 'wb') do |file|
        file.write @signature
        file.write @version
        file.write @character_name[0...32].ljust(32,"\x00")
        file.write Array(@character_data_offset).pack('V')
        file.write Array(@character_data_length).pack('V')
        file.write Array(@quick_weapon_1_index).pack('v')
        file.write Array(@quick_weapon_2_index).pack('v')
        file.write Array(@quick_weapon_3_index).pack('v')
        file.write Array(@quick_weapon_4_index).pack('v')
        file.write @quick_spell_1_resource
        file.write @quick_spell_2_resource
        file.write @quick_spell_3_resource
        file.write Array(@quick_item_1_index).pack('v')
        file.write Array(@quick_item_2_index).pack('v')
        file.write Array(@quick_item_3_index).pack('v')
        file.write Array(@show_quick_item_1).pack('v')
        file.write Array(@show_quick_item_2).pack('v')
        file.write Array(@show_quick_item_3).pack('v')

        file.write @creature_data
      end
    end
  
    def name
    
    end
  
    def name=(new_name)
    
    end
  
    def get_creature
    
    end
  
    def last_error
    
    end
  
    def has_changed?
    
    end
  end # class Character
end # module
