class ChangeDefaultBookingStatusInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bookings, :booking_status, "pending"
  end
end
