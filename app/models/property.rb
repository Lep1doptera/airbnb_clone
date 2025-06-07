class Property < ApplicationRecord
  belongs_to :user, foreign_key: "users_id"
  has_many :bookings, foreign_key: "properties_id"

  validates :property_address, presence: true, uniqueness: true
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :price_per_night, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :property_image_url, presence: true
end
