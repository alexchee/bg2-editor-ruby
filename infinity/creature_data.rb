# Used info from here:
# http://iesdp.gibberlings3.net/file_formats/ie_formats/cre_v1.htm

module Infinity 
  class CreatureData < Infinity::Base
    attr_string :signature, :length => 4
    attr_string :version, :length => 4
    attr_string :long_name_ref, :length => 4, :no_strip => true
    attr_string :short_name_ref, :length => 4, :no_strip => true

    # Bit Flags:
    #   * bit 0 Show longname in tooltip
    #   * bit 1 No corpse
    #   * bit 2 Keep corpse
    #   * bit 3 Original class was Fighter
    #   * bit 4 Original class was Mage
    #   * bit 5 Original class was Cleric
    #   * bit 6 Original class was Thief
    #   * bit 7 Original class was Druid
    #   * bit 8 Original class was Ranger
    #   * bit 9 Fallen Paladin
    #   * bit 10 Fallen Ranger
    #   * bit 11 Exportable
    #   * bit 12 Hide injury status in tooltip
    #   * bit 13 Quest critical / affected by alternative damage
    #   * bit 14 Can activate "Can not be used by NPC" triggers
    #   * bit 15 Been in Party
    #   * bit 16 Restore item in hand
    #   * bit 17 Un-sets bit 16
    #   * bit 24 Related to random walk (ea)
    #   * bit 25 Related to random walk (general)
    #   * bit 26 Related to random walk (race)
    #   * bit 27 Related to random walk (class)
    #   * bit 28 Related to random walk (specific)
    #   * bit 29 Related to random walk (gender)
    #   * bit 30 Related to random walk (alignment)
    #   * bit 31 Un-interruptable (memory only)
    # 
    #  A multiclass char is indicated is by the absence of any of the "original class" flags being set.
  	attr_binary :creature_flags, :length => 4

    attr_unsigned_32_int :xp_reward # Exp for Killing this creature
    attr_unsigned_32_int :xp_or_power_level # XP of party member or Power Level of summoned creature 
  	attr_unsigned_32_int :gold
    # Status flags - 4 bytes
  	attr_unsigned_32_int :permanent_status_flags # State IDs
  	attr_unsigned_16_int :current_hp
  	attr_unsigned_16_int :max_hp
  	attr_unsigned_16_int :animation_id

  	attr_string :unknown1, :length => 2
	
    # Character customizations 1 Byte each
  	attr_unsigned_8_int :color_metal
  	attr_unsigned_8_int :color_minor
  	attr_unsigned_8_int :color_major
  	attr_unsigned_8_int :color_skin
  	attr_unsigned_8_int :color_leather
  	attr_unsigned_8_int :color_armor
  	attr_unsigned_8_int :color_hair

  	attr_string :eff_version, :length => 1 # EFF structure version
  	attr_string :small_portrait, :length => 8
  	attr_string :large_portrait, :length => 8
  	attr_signed_8_int :reputation 
  	attr_unsigned_8_int :skill_hide_in_shadows_base 

  	attr_signed_16_int :ac_base
  	attr_signed_16_int :ac_effective
  	attr_signed_16_int :ac_mod_crushing
  	attr_signed_16_int :ac_mod_missile 
  	attr_signed_16_int :ac_mod_piercing
  	attr_signed_16_int :ac_mod_slashing

    # Char attributes
  	attr_unsigned_8_int :attribute_THAC0 
  	attr_unsigned_8_int :attribute_attacks
  	attr_unsigned_8_int :attribute_save_death
  	attr_unsigned_8_int :attribute_save_wands
  	attr_unsigned_8_int :attribute_save_polymorph
  	attr_unsigned_8_int :attribute_save_breath
  	attr_unsigned_8_int :attribute_save_spells
  	attr_unsigned_8_int :attribute_resist_fire
  	attr_unsigned_8_int :attribute_resist_cold
  	attr_unsigned_8_int :attribute_resist_electricity
  	attr_unsigned_8_int :attribute_resist_acid
  	attr_unsigned_8_int :attribute_resist_magic
  	attr_unsigned_8_int :attribute_resist_magicfire
  	attr_unsigned_8_int :attribute_resist_magiccold
  	attr_unsigned_8_int :attribute_resist_slashing
  	attr_unsigned_8_int :attribute_resist_crushing
  	attr_unsigned_8_int :attribute_resist_piercing
  	attr_unsigned_8_int :attribute_resist_missile

    # Skills
  	attr_unsigned_8_int :skill_detect_illusions
  	attr_unsigned_8_int :skill_set_traps
  	attr_unsigned_8_int :skill_lore
  	attr_unsigned_8_int :skill_open_locks
  	attr_unsigned_8_int :skill_move_silently
  	attr_unsigned_8_int :skill_find_traps
  	attr_unsigned_8_int :skill_pick_pockets
  	attr_unsigned_8_int :skill_fatique
  	attr_unsigned_8_int :skill_intoxication
  	attr_unsigned_8_int :skill_luck

    # === DEPRECATED in BG2 ===
    # Weapon proficiencies - 1 byte each - 15 bytes
    # These proficienciens seem to be obsolete in BGII. Instead they are
    # tacked onto the end of the CRE with affect structs. I've made two
    # function to replace these: GetProf and SetProf. It uses the 
    # proficiency values from global.h.
  	attr_unsigned_8_int :proficiencies_large_swords
  	attr_unsigned_8_int :proficiencies_small_swords
  	attr_unsigned_8_int :proficiencies_bows
  	attr_unsigned_8_int :proficiencies_spears
  	attr_unsigned_8_int :proficiencies_blunt
  	attr_unsigned_8_int :proficiencies_spiked
  	attr_unsigned_8_int :proficiencies_axes
  	attr_unsigned_8_int :proficiencies_missiles

  	attr_string :unknown2, :length => 13
  	attr_unsigned_8_int :skill_tracking
  	attr_string :unknown3, :length => 32
  	attr_string :reference_ids, :length => 400
    # Classes - 1 byte each, 3 bytes total
  	attr_unsigned_8_int :class_1_level
  	attr_unsigned_8_int :class_2_level
  	attr_unsigned_8_int :class_3_level

  	attr_unsigned_8_int :gender # 1 byte

    # Char Stats
    attr_unsigned_8_int :stat_str
    attr_unsigned_8_int :stat_str_bonus
    attr_unsigned_8_int :stat_int
    attr_unsigned_8_int :stat_wis
    attr_unsigned_8_int :stat_dex
    attr_unsigned_8_int :stat_con
    attr_unsigned_8_int :stat_char
    attr_unsigned_8_int :stat_morale
    attr_unsigned_8_int :stat_morale_break
    attr_unsigned_8_int :stat_racial_enemy

  	attr_unsigned_16_int :stat_morale_recover_time # Morale Recovery Time - Integer - 2 bytes
    # Kit info: The values of this offset are written in big endian style
    # NONE              0x00000000
    # KIT_BARBARIAN     0x00004000
    # KIT_TRUECLASS     0x40000000
    # KIT_BERSERKER     0x40010000
    # KIT_WIZARDSLAYER  0x40020000
    # KIT_KENSAI        0x40030000
    # KIT_CAVALIER      0x40040000
    # KIT_INQUISITOR    0x40050000
    # KIT_UNDEADHUNTER  0x40060000
    # KIT_ARCHER        0x40070000
    # KIT_STALKER       0x40080000
    # KIT_BEASTMASTER   0x40090000
    # KIT_ASSASSIN      0x400A0000
    # KIT_BOUNTYHUNTER  0x400B0000
    # KIT_SWASHBUCKLER  0x400C0000
    # KIT_BLADE         0x400D0000
    # KIT_JESTER        0x400E0000
    # KIT_SKALD         0x400F0000
    # KIT_TOTEMIC       0x40100000
    # KIT_SHAPESHIFTER  0x40110000
    # KIT_AVENGER       0x40120000
    # KIT_GODTALOS      0x40130000
    # KIT_GODHELM       0x40140000
    # KIT_GODLATHANDER  0x40150000
    # ABJURER           0x00400000
    # CONJURER          0x00800000
    # DIVINER           0x01000000
    # ENCHANTER         0x02000000
    # ILLUSIONIST       0x04000000
    # INVOKER           0x08000000
    # NECROMANCER       0x10000000
    # TRANSMUTER        0x20000000
    # 
  	attr_string :kit, :length => 4
    # Script refs
  	attr_string :script_override, :length => 8
  	attr_string :script_class, :length => 8
  	attr_string :script_race, :length => 8
  	attr_string :script_general, :length => 8
  	attr_string :script_default, :length => 8

  	attr_unsigned_8_int :enemy_ally_id
  	attr_unsigned_8_int :general_id
  	attr_unsigned_8_int :race_id
  	attr_unsigned_8_int :class_id
  	attr_unsigned_8_int :specific_id
  	attr_unsigned_8_int :gender_id # used to determine casting voice

  	attr_string :object_references, :length => 5
  	attr_unsigned_8_int :alignment_id
  	attr_string :actor_global, :length => 2
  	attr_string :actor_local, :length => 2
  	attr_string :death_variable, :length => 32 # death var. set SPRITE_IS_DEADvariable on death
    # DWORD, (32bit Integers)/4 bytes each - 44 bytes total
    	attr_unsigned_32_int :known_spells_offset
  	attr_unsigned_32_int :known_spells_count
  	attr_unsigned_32_int :spell_memorization_offset
  	attr_unsigned_32_int :spell_memorization_count
  	attr_unsigned_32_int :memorized_spells_offset
  	attr_unsigned_32_int :memorized_spells_count
  	attr_unsigned_32_int :inventory_offset
  	attr_unsigned_32_int :items_offset
  	attr_unsigned_32_int :items_count
  	attr_unsigned_32_int :effects_offset
  	attr_unsigned_32_int :effects_count

  	attr_string :dialogue_file, :length => 8
    # Lore is calculated as ((level * rate) + int_bonus + wis_bonus). Intelligence and wisdom bonuses are from lorebon.2da and the rate is the lookup value in lore.2da, based on class. For multiclass characters, (level * rate) is calculated for both classes separately and the higher of the two values is used - they are not cumulative.
	  
	  attr_accessor :known_spells_data
	  attr_accessor :memorized_spells_data
	  attr_accessor :memorized_spells_table_data
	  attr_accessor :effects_data
	  attr_accessor :items_data
	  attr_accessor :inventory_data
	  INVENTORY = {
      :helmet                  => 0,
      :armor                   => 1,
      :shield                  => 2,
      :gloves                  => 3,
      :left_ring               => 4,
      :right_ring              => 5,
      :amulet                  => 6,
      :belt                    => 7,
      :boots                   => 8,
      :weapon1                 => 9,
      :weapon2                 => 10,
      :weapon3                 => 11,
      :weapon4                 => 12,
      :quiver1                 => 13,
      :quiver2                 => 14,
      :quiver3                 => 15,
      :unknown                 => 16,
      :cloak                   => 17,
      :quick_item1             => 18,
      :quick_item2             => 19,
      :quick_item3             => 20,
      :inventory1              => 21,
      :inventory2              => 22,
      :inventory3              => 23,
      :inventory4              => 24,
      :inventory5              => 25,
      :inventory6              => 27,
      :inventory7              => 28,
      :inventory8              => 29,
      :inventory9              => 30,
      :inventory10             => 31,
      :inventory11             => 32,
      :inventory12             => 33,
      :inventory13             => 34,
      :inventory14             => 35,
      :inventory15             => 36,
      :inventory16             => 37,
      :magic_weapon            => 38,
      :selected_weapon         => 39,
      :selected_weapon_ability => 40

    }
	  
  	def self.load_data(data, offset=0)
  	  creature_data = self.new()
  	  creature_data.raw_data =  data[offset..-1]
  	  creature_data.extract_bytes!
      
      creature_data.load_known_spells_data
      creature_data.load_memorized_spells_data
      creature_data.load_items_data
      creature_data.load_effects_data
      creature_data.load_inventory_data
      
    	creature_data
  	end
    
    def load_known_spells_data
      @known_spells_data = get_array_of_object(Infinity::SpellBlock, get_infinity_attr("unsigned_32_int", "known_spells_offset"), get_infinity_attr("unsigned_32_int", "known_spells_count"))
    end
    
    def load_memorized_spells_data
      offset = get_infinity_attr("unsigned_32_int", "memorized_spells_offset")
      count = get_infinity_attr("unsigned_32_int", "memorized_spells_count")
      @memorized_spells_data = get_array_of_object(Infinity::MemorizationInfo, offset, count)
      offset += count*Infinity::MemorizationInfo.data_size
      @memorized_spells_table_data = get_array_of_object(Infinity::MemorizedSpellBlock, offset, count)
    end
    
    def load_items_data
      offset = get_infinity_attr("unsigned_32_int", "items_offset")
      count = get_infinity_attr("unsigned_32_int", "items_count")
      @items_data = get_array_of_object(Infinity::ItemBlock, offset, count)
    end
    
    def load_effects_data
      @effects_data = []
      count = get_infinity_attr("unsigned_32_int", "effects_count")
      offset = get_infinity_attr("unsigned_32_int", "effects_offset")
      bytes = 4
      1.upto(count) do |num|
        @effects_data << extract_string(self.raw_data, offset, bytes, false)
        offset += bytes
      end
      
    end
    
    # 40 slots
    # * Helmet
    # * Armor
    # * Shield
    # * Gloves
    # * L.Ring
    # * R.Ring
    # * Amulet
    # * Belt
    # * Boots
    # * Weapon 1
    # * Weapon 2
    # * Weapon 3
    # * Weapon 4
    # * Quiver 1
    # * Quiver 2
    # * Quiver 3
    # * ?
    # * Cloak
    # * Quick item 1
    # * Quick item 2
    # * Quick item 3
    # * Inventory item (1 to 16)
    # * Magic weapon
    # * Selected weapon
    # * Selected weapon ability
    # Each entry will be either (0xFFFF = 65535) ("empty") or an index into the Items table. Selected is a dword indicating which weapon slot us currently selected. Values are from slots.ids - 35, with 1000 meaning "fist".
    def load_inventory_data
      offset = get_infinity_attr("unsigned_32_int", "inventory_offset")
      bytes = 2
      count = 40
      
      @inventory_data = []
      1.upto(count) do |num|
        @inventory_data << extract_string(self.raw_data, offset, bytes, false)
        offset += bytes
      end
    end
	
	  def data_dump
	    data_string = super
	    data_string += @known_spells_data.map(&:data_dump).join('')

      data_string += @memorized_spells_data.map(&:data_dump).join('')

      data_string += @memorized_spells_table_data.map(&:data_dump).join('')

      data_string += @effects_data.join('')

      data_string += @items_data.map(&:data_dump).join('')

      data_string += @inventory_data.join('')
	  end
	  
	
  end # class CreatureData

  class SpellBlock < Infinity::Base
    attr_string :reference_name, :length => 8
    attr_unsigned_16_int :level
    attr_unsigned_16_int :type
  end

  # details how many spells the creature can memorize, and how many it has memorized. It consists of an array of entries formatted as follows.
  class MemorizationInfo < Infinity::Base
    attr_unsigned_16_int :level
    attr_unsigned_16_int :number_memorized
    # Number of spells memorizable (after effects)
    attr_unsigned_16_int :number_memorized_affected
    # 0 - Priest
    # 1 - Wizard
    # 2 - Innate
    attr_unsigned_16_int :spell_type
    # Index into memorized spells array of first memorized spell of this type in this level.
    attr_unsigned_32_int :memorized_spell_index
    # Count of memorized spell entries in memorized spells array of memorized spells of this type in this level.
    attr_unsigned_32_int :memorized_spell_count
    
    
  end

  # spell the creature has memorized
  class MemorizedSpellBlock < Infinity::Base
    attr_string :reference_name, :length => 8
    # 0 - No
    # 1 - Yes
    attr_unsigned_16_int :memorized
  end

  # items the creature has
  class ItemBlock < Infinity::Base
    attr_string :reference_name, :length => 8
    # Item expiration time - item creation hour (replace with drained item)
    attr_unsigned_8_int :expire_time_created_hour
    # Item expiration time - (elapsed hour count divided by 256, rounded down) + 1 (replace with drained item)
    # When the game hour and elapsed hour count for the current game time exceed these values, the item is removed.
    attr_unsigned_8_int :expire_time_elapsed_hour
    attr_unsigned_16_int :qty_or_charges1
    attr_unsigned_16_int :qty_or_charges2
    attr_unsigned_16_int :qty_or_charges3
    # Item flags
    # bit 0: Identified
    # bit 1: Unstealable
    # bit 2: Stolen
    # bit 3: Undroppable
    attr_unsigned_32_int :flags
  end
end