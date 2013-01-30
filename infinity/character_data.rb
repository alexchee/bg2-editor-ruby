# Based off of info from here:
# http://iesdp.gibberlings3.net/file_formats/ie_formats/chr_v2.htm#CHRV2_0_CHR_Header

module Infinity
  class CharacterData < Infinity::Base
    attr_string :signature, :length => 4
    attr_string :version, :length => 4
    attr_string :character_name, :length => 32
    attr_unsigned_32_int :character_data_offset
    attr_unsigned_32_int :character_data_length
    # Quick Weapon slots - stores index of weapon
    # Disabled is 0xff or 65535
    attr_unsigned_16_int :quick_weapon_1_index
    attr_unsigned_16_int :quick_weapon_2_index
    attr_unsigned_16_int :quick_weapon_3_index
    attr_unsigned_16_int :quick_weapon_4_index
    # Show quick weapon slot toggle
    # Show Slot = 0x00 or 0
    # Hide Slot = 0xFF or 65535
    attr_unsigned_16_int :show_quick_weapon_1
    attr_unsigned_16_int :show_quick_weapon_2
    attr_unsigned_16_int :show_quick_weapon_3
    attr_unsigned_16_int :show_quick_weapon_4
    attr_string :quick_spell_1_resource, :length => 8
    attr_string :quick_spell_2_resource, :length => 8
    attr_string :quick_spell_3_resource, :length => 8
    # Quick Item slots - stores index of item
    attr_unsigned_16_int :quick_item_1_index
    attr_unsigned_16_int :quick_item_2_index
    attr_unsigned_16_int :quick_item_3_index
    # Show quick item slot toggle
    # Show Slot = 0x00 or 0
    # Hide Slot = 0xFF or 65535
    attr_unsigned_16_int :show_quick_item_1
    attr_unsigned_16_int :show_quick_item_2
    attr_unsigned_16_int :show_quick_item_3
    
    attr_accessor :creature_data

    def self.load_file(file)
    	if (file=File.open(file,'rb'))
    	  char_data = self.new()
    	  data = file.read
    	  char_data.raw_data = data
        char_data.extract_bytes!
        
        # Could cheat and just go to end
        # char_data.creature_data = data.byteslice(@character_data_offset..-1)

    	  char_data
  	  else
  	    raise "Error cannot open file"
      end
    end

    def extract_bytes!
      super
      
      self.creature_data = Infinity::CreatureData.load_data(self.get_offseted_data(get_infinity_attr("unsigned_32_int", "character_data_offset"), get_infinity_attr("unsigned_32_int", "character_data_length")))
    end
    

    def write_to_file(path)
      File.open(path, 'wb') do |file|
        file.write(self.data_dump + @creature_data.data_dump)
      end
    end
  end # class Character
end # module
