class RenameBookingForeignKeys < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :users_id, :user_id
    rename_column :bookings, :properties_id, :property_id
  end
end
