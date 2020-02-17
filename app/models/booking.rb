class Booking < ApplicationRecord
  validate :start_date, presence: true
  validate :end_date, presence: true

  belongs_to :user
  belongs_to :animal
  has_many :reviews
end
