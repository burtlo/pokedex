class CreateTypeDamageMultipliers < ActiveRecord::Migration
  def change
    create_table :type_damage_multipliers do |t|
      t.string :type_name
      t.string :multipliers

      t.timestamps
    end
  end
end
