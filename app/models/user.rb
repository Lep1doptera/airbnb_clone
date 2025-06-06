class User < ApplicationRecord
  has_many :properties, foreign_key: "users_id"
  has_many :bookings, foreign_key: "users_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
