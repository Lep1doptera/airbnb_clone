class Booking < ApplicationRecord
  belongs_to :properties
  belongs_to :user

  validates :check_in_date, :check_out_date, presence: true
end
