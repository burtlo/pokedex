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
    type_effects_grouped_by_type_name.map do |type_name,effects|
      multiplier = effects.inject(1.0) { |sum,effect| effect.multiplier * sum }
      OpenStruct.new(name: type_name, multiplier: multiplier)
    end
  end

  def type_effects_grouped_by_type_name
    type_effects.group_by { |te| te.name }
  end

  def type_effects
    types.map { |t| TypeEffect.where(other_type_id: t.id) }.flatten
  end

  def name
    attributes["name"].encode('utf-8', 'iso-8859-1')
  end

  def image_name
    "#{index.to_s.rjust(3,'0')}.png"
  end
end
