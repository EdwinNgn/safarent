class Animal < ApplicationRecord
  validate :name, presence: true, uniqueness: true
  validate :animal_type, presence: true
  validate :price_per_day, presence: true
  validate :location, presence: true
  validate :description, presence: true
  has_many :bookings
  has_many :reviews, through: :bookings
  belongs_to :user

end
