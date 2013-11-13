class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :level
      t.string :name
      t.references :type, index: true
      t.string :category
      t.integer :attack
      t.integer :accuracy
      t.integer :points
      t.integer :effect_percent
      t.text :description

      t.timestamps
    end
  end
end
