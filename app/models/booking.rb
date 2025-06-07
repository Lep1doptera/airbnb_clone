class Booking < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :check_in_date, :check_out_date, presence: true
  validates :number_of_guests, numericality: { only_integer: true, greater_than: 0 }
end
