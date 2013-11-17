class Pokemon < ActiveRecord::Base
  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  has_many :pokemon_moves
  has_many :moves, through: :pokemon_moves

  def effective_types_against
    type_damage_multipliers.find_all { |effect| effect.multiplier > 1.0 }
  end

  def ineffective_types_against
    type_damage_multipliers.find_all { |effect| effect.multiplier < 1.0 }
  end

  def type_damage_multipliers
    TypeDamageMultiplier.damage_for(types)
  end

  def name
    attributes["name"].encode('utf-8', 'iso-8859-1')
  end

  def image_name
    "#{index.to_s.rjust(3,'0')}.png"
  end
end
