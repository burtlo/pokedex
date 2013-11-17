# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Dir["#{Rails.root}/db/pokemon/*.json"].each do |json_file|
  pokemon_json = File.read(json_file)
  data = JSON.parse(pokemon_json)

  name = data["name"]
  index = data["index"]

  pokemon = Pokemon.find_by_index(index)

  if pokemon.nil?
    puts "Creating:#{name}"
    pokemon = Pokemon.new(name: name,index: index)
  end

  # generate types if types are not present
  types = data["types"].map do |type_name|
    Type.find_by_name(type_name) || Type.create(name: type_name)
  end

  pokemon.types = types

  moves = data["moves"].map do |move_data|
    type_name = move_data["type"]
    type = Type.find_by_name(type_name) || Type.create(name: type_name)

    Move.find_by_name(move_data["name"]) || begin
      puts "Creating Move: #{move_data["name"]}"
      Move.create(
        level: move_data["level"].to_i,
        name: move_data["name"],
        type_id: type.id,
        category: move_data["category"],
        attack: move_data["attack"].to_i,
        accuracy: move_data["accuracy"].to_i,
        points: move_data["pp"].to_i,
        effect_percent: move_data["effect_percent"].to_i,
        description: move_data["description"])
    end
  end

  pokemon.moves = moves

  pokemon.save

end

def type_names
  %w[ normal fighting flying poison ground
     rock bug ghost steel fire water grass
     electric psychic ice dragon dark fairy ]
end

def types
  type_names.map { |name| Type.find_by_name(name) }
end

types.each do |type|
  puts "Building Type Effects for #{type.name}"
  # remaining_types = (types - [ type ]).compact
  types.each do |opposing_type|
    next if type.type_effects.detect {|t| t.other_type_id == opposing_type.id }
    type.type_effects.create other_type_id: opposing_type.id, multiplier: 1.0
  end
end

def set_type_effect_to(original,other,multiplier)
  puts "Setting #{original} vs #{other} to #{multiplier}"
  type = types.find { |type| type.name == original }
  opposing = types.find { |type| type.name == other }

  type_to_other = type.type_effects.where(other_type_id: opposing.id).first
  type_to_other.multiplier = multiplier
  type_to_other.save
end

set_type_effect_to("normal","rock",0.5)
set_type_effect_to("normal","steel",0.5)
set_type_effect_to("normal","ghost",0.0)

set_type_effect_to("fighting","normal",2.0)
set_type_effect_to("fighting","flying",0.5)
set_type_effect_to("fighting","poison",0.5)
set_type_effect_to("fighting","rock",2.0)
set_type_effect_to("fighting","bug",0.5)
set_type_effect_to("fighting","ghost",0.0)
set_type_effect_to("fighting","psychic",0.5)
set_type_effect_to("fighting","ice",2.0)
set_type_effect_to("fighting","dark",2.0)
set_type_effect_to("fighting","fairy",0.5)

set_type_effect_to("flying","fighting",2.0)
set_type_effect_to("flying","rock",0.5)
set_type_effect_to("flying","bug",2.0)
set_type_effect_to("flying","steel",0.5)
set_type_effect_to("flying","grass",2.0)
set_type_effect_to("flying","electric",0.5)

set_type_effect_to("poison","poison",0.5)
set_type_effect_to("poison","ground",0.5)
set_type_effect_to("poison","rock",0.5)
set_type_effect_to("poison","ghost",0.5)
set_type_effect_to("poison","steel",0.0)
set_type_effect_to("poison","grass",2.0)
set_type_effect_to("poison","fairy",2.0)

set_type_effect_to("ground","flying",0.0)
set_type_effect_to("ground","poison",2.0)
set_type_effect_to("ground","rock",2.0)
set_type_effect_to("ground","bug",0.5)
set_type_effect_to("ground","steel",2.0)
set_type_effect_to("ground","fire",2.0)
set_type_effect_to("ground","grass",0.5)
set_type_effect_to("ground","electric",2.0)

set_type_effect_to("rock","fighting",0.5)
set_type_effect_to("rock","flying",2.0)
set_type_effect_to("rock","ground",0.5)
set_type_effect_to("rock","bug",2.0)
set_type_effect_to("rock","steel",0.5)
set_type_effect_to("rock","fire",2.0)
set_type_effect_to("rock","ice",2.0)

set_type_effect_to("bug","fighting",0.5)
set_type_effect_to("bug","flying",0.5)
set_type_effect_to("bug","poison",0.5)
set_type_effect_to("bug","ghost",0.5)
set_type_effect_to("bug","steel",0.5)
set_type_effect_to("bug","fire",0.5)
set_type_effect_to("bug","grass",2.0)
set_type_effect_to("bug","psychic",2.0)
set_type_effect_to("bug","dark",2.0)
set_type_effect_to("bug","fairy",0.5)

set_type_effect_to("ghost","normal",0.0)
set_type_effect_to("ghost","ghost",2.0)
set_type_effect_to("ghost","psychic",2.0)
set_type_effect_to("ghost","dark",0.5)

set_type_effect_to("steel","rock",2.0)
set_type_effect_to("steel","steel",0.5)
set_type_effect_to("steel","fire",0.5)
set_type_effect_to("steel","water",0.5)
set_type_effect_to("steel","electric",0.5)
set_type_effect_to("steel","ice",2.0)
set_type_effect_to("steel","fairy",2.0)

set_type_effect_to("fire","rock",0.5)
set_type_effect_to("fire","bug",2.0)
set_type_effect_to("fire","steel",2.0)
set_type_effect_to("fire","fire",0.5)
set_type_effect_to("fire","water",0.5)
set_type_effect_to("fire","grass",2.0)
set_type_effect_to("fire","ice",2.0)
set_type_effect_to("fire","dragon",0.5)

set_type_effect_to("water","ground",2.0)
set_type_effect_to("water","rock",2.0)
set_type_effect_to("water","fire",2.0)
set_type_effect_to("water","water",0.5)
set_type_effect_to("water","grass",0.5)
set_type_effect_to("water","dragon",0.5)

set_type_effect_to("grass","flying",0.5)
set_type_effect_to("grass","poison",0.5)
set_type_effect_to("grass","ground",2.0)
set_type_effect_to("grass","rock",2.0)
set_type_effect_to("grass","bug",0.5)
set_type_effect_to("grass","steel",0.5)
set_type_effect_to("grass","fire",0.5)
set_type_effect_to("grass","water",2.0)
set_type_effect_to("grass","grass",0.5)
set_type_effect_to("grass","dragon",0.5)

set_type_effect_to("electric","flying",2.0)
set_type_effect_to("electric","ground",0.0)
set_type_effect_to("electric","water",2.0)
set_type_effect_to("electric","grass",0.5)
set_type_effect_to("electric","electric",0.5)
set_type_effect_to("electric","dragon",0.5)

set_type_effect_to("psychic","fighting",2.0)
set_type_effect_to("psychic","poison",2.0)
set_type_effect_to("psychic","steel",0.5)
set_type_effect_to("psychic","psychic",0.5)
set_type_effect_to("psychic","dark",0.0)

set_type_effect_to("ice","flying",2.0)
set_type_effect_to("ice","ground",2.0)
set_type_effect_to("ice","steel",0.5)
set_type_effect_to("ice","fire",0.5)
set_type_effect_to("ice","water",0.5)
set_type_effect_to("ice","grass",2.0)
set_type_effect_to("ice","ice",0.5)
set_type_effect_to("ice","dragon",2.0)

set_type_effect_to("dragon","steel",0.5)
set_type_effect_to("dragon","dragon",2.0)
set_type_effect_to("dragon","fairy",0.0)

set_type_effect_to("dark","fighting",0.5)
set_type_effect_to("dark","ghost",2.0)
set_type_effect_to("dark","psychic",2.0)
set_type_effect_to("dark","dark",0.5)
set_type_effect_to("dark","fairy",0.5)

set_type_effect_to("fairy","fighting",2.0)
set_type_effect_to("fairy","poison",0.5)
set_type_effect_to("fairy","steel",0.5)
set_type_effect_to("fairy","fire",0.5)
set_type_effect_to("fairy","dragon",2.0)
set_type_effect_to("fairy","dark",2.0)


types_to_colors = { normal: "a8a878",
  fighting: "c03028",
  flying: "a890f0",
  poison: "a040a0",
  ground: "e0c068",
  rock: "b8a038",
  bug: "a8b820",
  ghost: "705898",
  steel: "b8b8d0",
  fire: "f08030",
  water: "6890f0",
  grass: "78c850",
  electric: "f8d030",
  psychic: "f85888",
  ice: "98d8d8",
  dragon: "7038f8",
  dark: "705848",
  fairy: "ee99ac"
   }

types_to_colors.each do |type_name,color|
  puts "Setting type color: #{type_name} to #{color}"
  type = Type.find_by_name(type_name)
  type.color = color
  type.save
end