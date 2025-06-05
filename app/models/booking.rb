class Booking < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :check_in_date, :check_out_date, presence: true
end
