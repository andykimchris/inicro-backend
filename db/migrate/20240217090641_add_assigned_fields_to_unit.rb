class AddAssignedFieldsToUnit < ActiveRecord::Migration[7.1]
  def change
    add_column :units, :assigned_at, :datetime
    add_column :units, :assigned_by_id, :uuid
  end
end
