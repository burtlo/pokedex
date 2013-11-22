class AddEvolvesToAndEventToPokemonEvolutions < ActiveRecord::Migration
  def change
    add_column :pokemon_evolutions, :evolves_to, :integer
    add_column :pokemon_evolutions, :event, :text
  end
end
