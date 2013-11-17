class TypeDamageMultiplier < ActiveRecord::Base
  def self.damage_for(types)
    damage_chart = find_by_type_name(type_name(types))

    if damage_chart
      multiplier_hash = JSON.parse(damage_chart.multipliers)
      multiplier_hash.map do |properties|
        OpenStruct.new(properties)
      end
    else
      calc = calculate_type_effects(types)
      calc_hash = calc.map { |e| { name: e.name, multiplier: e.multiplier} }
      create(type_name: type_name(types),multipliers: calc_hash.to_json)
      calc
    end

  end

  def self.type_name(types)
    types.map { |type| type.name }.sort.join("-")
  end

  def self.calculate_type_effects(types)
    type_effects_grouped_by_type_name(types).map do |type_name,effects|
      multiplier = effects.inject(1.0) { |sum,effect| effect.multiplier * sum }
      OpenStruct.new(name: type_name, multiplier: multiplier)
    end
  end

  def self.type_effects_grouped_by_type_name(types)
    type_effects(types).group_by { |te| te.name }
  end

  def self.type_effects(types)
    types.map { |t| TypeEffect.where(other_type_id: t.id) }.flatten
  end

end