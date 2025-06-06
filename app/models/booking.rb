class Booking < ApplicationRecord
  belongs_to :property, foreign_key: "properties_id"
  belongs_to :user, foreign_key: "users_id"
  
  validates :check_in_date, :check_out_date, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
end
