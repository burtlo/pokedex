class CreateTypeEffects < ActiveRecord::Migration
  def change
    create_table :type_effects do |t|
      t.references :type, index: true
      t.integer :other_type_id
      t.float :multiplier

      t.timestamps
    end
  end
end
