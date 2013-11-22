class PokemonEvolution < ActiveRecord::Base
  belongs_to :pokemon

  def evolves_to
    Pokemon.find_by_index(attributes["evolves_to"])
  end
end
