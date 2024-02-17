class AddExtraFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :secondary_phone_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_internal, :boolean, default: false
    add_column :users, :is_active, :boolean, default: false
    add_column :users, :is_support, :boolean
  end
end
