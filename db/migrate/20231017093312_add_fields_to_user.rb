class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_proprietor, :boolean, null: false
    add_column :users, :is_occupant, :boolean, null: false
  end
end
