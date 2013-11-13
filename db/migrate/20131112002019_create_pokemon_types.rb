class CreatePokemonTypes < ActiveRecord::Migration
  def change
    create_table :pokemon_types do |t|
      t.references :pokemon, index: true
      t.references :type, index: true

      t.timestamps
    end
  end
end
