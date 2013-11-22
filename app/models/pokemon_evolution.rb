class PokemonEvolution < ActiveRecord::Base
  belongs_to :pokemon

  def evolves_to
    Pokemon.find(attributes["evolves_to"])
  end
end
