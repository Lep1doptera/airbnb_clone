class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :check_in_date
      t.date :check_out_date

      t.timestamps
    end
  end
end
