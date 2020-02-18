class Animal < ApplicationRecord
  validates :name, presence: true
  validates :animal_type, presence: true
  validates :price_per_day, presence: true
  validates :location, presence: true
  validates :species, presence: true
  validates :description, presence: true
  has_many :bookings
  has_many :reviews, through: :bookings
  belongs_to :user
  has_many_attached :photos
end
