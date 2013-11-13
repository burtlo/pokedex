class CreatePokemonMoves < ActiveRecord::Migration
  def change
    create_table :pokemon_moves do |t|
      t.references :pokemon, index: true
      t.references :move, index: true

      t.timestamps
    end
  end
end
