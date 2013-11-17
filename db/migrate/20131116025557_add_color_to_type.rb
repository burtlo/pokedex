class AddColorToType < ActiveRecord::Migration
  def change
    add_column :types, :color, :string
  end
end
