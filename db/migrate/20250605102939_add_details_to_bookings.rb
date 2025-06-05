class AddDetailsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :booking_status, :string
    add_column :bookings, :number_of_guests, :integer
    add_reference :bookings, :properties, null: false, foreign_key: true
    add_reference :bookings, :users, null: false, foreign_key: true
  end
end
