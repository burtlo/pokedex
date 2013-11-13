class CreatePokemonEvolutions < ActiveRecord::Migration
  def change
    create_table :pokemon_evolutions do |t|
      t.references :pokemon, index: true

      t.timestamps
    end
  end
end
