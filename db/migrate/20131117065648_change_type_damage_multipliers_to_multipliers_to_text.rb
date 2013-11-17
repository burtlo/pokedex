class ChangeTypeDamageMultipliersToMultipliersToText < ActiveRecord::Migration
  def change
    remove_column :type_damage_multipliers, :multipliers
    add_column :type_damage_multipliers, :multipliers, :text
  end
end
