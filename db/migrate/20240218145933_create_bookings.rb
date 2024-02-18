class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :unit, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.datetime :booking_set_at
      t.string :booking_assigned_to_id

      t.timestamps
    end
  end
end
