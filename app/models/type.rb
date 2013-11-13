class Type < ActiveRecord::Base

  has_many :pokemon_types
  has_many :pokemon, through: :pokemon_types

  has_many :moves

  has_many :type_effects

  def does_double_damage_to
    type_effects.where(multiplier: 2.0)
  end

  def does_half_damage_to
    type_effects.where(multiplier: 0.5)
  end

  def does_no_damage_to
    type_effects.where(multiplier: 0.0)
  end

  def takes_double_damage_from
    TypeEffect.where(other_type_id: id,multiplier: 2.0)
  end

  def takes_half_damage_from
    TypeEffect.where(other_type_id: id,multiplier: 0.5)
  end

  def takes_no_damage_from
    TypeEffect.where(other_type_id: id,multiplier: 0.0)
  end

end
