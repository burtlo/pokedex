class RemoveColorFromTypes < ActiveRecord::Migration
  def change
    remove_column :types, :color
  end
end
