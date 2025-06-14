class Property < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :property_address, presence: true, uniqueness: true
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :price_per_night, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :property_image_url, presence: true
  geocoded_by :property_address
  after_validation :geocode, if: :will_save_change_to_property_address?
end
