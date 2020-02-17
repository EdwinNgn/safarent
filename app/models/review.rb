class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true
  validates :review_type, presence: true
  validates :description, presence: true
end
