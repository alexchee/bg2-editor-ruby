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
  	attr_unsigned_8_int :proficiencies_axes
  	attr_unsigned_8_int :proficiencies_missiles
  	attr_unsigned_8_int :proficiencies_great_swords
  	attr_unsigned_8_int :proficiencies_daggers
  	attr_unsigned_8_int :proficiencies_halberds
  	attr_unsigned_8_int :proficiencies_maces
  	attr_unsigned_8_int :proficiencies_flails
  	attr_unsigned_8_int :proficiencies_hammers
  	attr_unsigned_8_int :proficiencies_clubs
  	attr_unsigned_8_int :proficiencies_quarterstaffs
  	attr_unsigned_8_int :proficiencies_crossbows

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
  	attr_unsigned_32_int :item_slots_offset
  	attr_unsigned_32_int :items_offset
  	attr_unsigned_32_int :items_count
  	attr_unsigned_32_int :effects_offset
  	attr_unsigned_32_int :effects_count

  	attr_string :dialogue_file, :length => 8
    # Lore is calculated as ((level * rate) + int_bonus + wis_bonus). Intelligence and wisdom bonuses are from lorebon.2da and the rate is the lookup value in lore.2da, based on class. For multiclass characters, (level * rate) is calculated for both classes separately and the higher of the two values is used - they are not cumulative.
	
  	def self.load_data(data, offset=0)
  	  creature_data = self.new()
  	  creature_data.raw_data =  data[offset..-1]
  	  creature_data.extract_bytes!
      
      # offset = 0
      # chunk = 0
      # creature_data.signature = data.byteslice(offset,chunk=4)
      # creature_data.version = data.byteslice(offset+=chunk,chunk=4)
      # creature_data.long_name_ref = data.byteslice(offset+=chunk,chunk=4)
      # creature_data.short_name_ref = data.byteslice(offset+=chunk,chunk=4)
      #       creature_data.creature_flags = data.byteslice(offset+=chunk,chunk=4)
      #       creature_data.xp_reward = data.byteslice(offset+=chunk,chunk=4).unpack("V").first
      #       creature_data.xp_or_power_level = data.byteslice(offset+=chunk,chunk=4).unpack("V").first
      #       creature_data.gold = data.byteslice(offset+=chunk,chunk=4).unpack("V").first
      #       creature_data.permanent_status_flags = data.byteslice(offset+=chunk,chunk=4).unpack("V").first
      #       creature_data.current_hp = data.byteslice(offset+=chunk,chunk=2).unpack("S").first
      #       creature_data.max_hp  = data.byteslice(offset+=chunk,chunk=2).unpack("S").first
      #       creature_data.animation_id = data.byteslice(offset+=chunk,chunk=2).unpack("S").first
      #       creature_data.unknown1 = data.byteslice(offset+=chunk,chunk=2)
      #       creature_data.color_metal = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_minor = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_major = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_skin = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_leather = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_armor = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.color_hair = data.byteslice(offset+=chunk,chunk=1).unpack("c").first
      #       creature_data.eff_version = data.byteslice(offset+=chunk,chunk=1)
      #       creature_data.small_portrait = data.byteslice(offset+=chunk,chunk=8).strip
      #       creature_data.large_portrait = data.byteslice(offset+=chunk,chunk=8).strip
      #       creature_data.reputation = data.byteslice(offset+=chunk,chunk=1).unpack('c').first
      #       creature_data.skill_hide_in_shadows_base = data.byteslice(offset+=chunk,chunk=1).unpack('C').first
      #       creature_data.ac_base = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       creature_data.ac_effective = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       creature_data.ac_mod_crushing = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       creature_data.ac_mod_missile = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       creature_data.ac_mod_piercing = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       creature_data.ac_mod_slashing = data.byteslice(offset+=chunk,chunk=2).unpack('s').first
      #       
      #       
    	creature_data
  	end

    # def to_s
    #   
    # end
    
    def dump_to_file(file_path)
      
    end
    
	
  end


  class SpellBlock
    # 8 bytes
    attr_accessor :chSpellName
    # WORD - 2 bytes
    attr_accessor :wSpellLevel
    # WORD - 2 bytes
    attr_accessor :wSpellType
  
    def load(data, offset=0)
      @chSpellName = data[offset,8]
      @wSpellLevel = data[offset+8,2]
      @wSpellType = data[offset+2,2]
    end
  end
end