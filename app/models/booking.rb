class Booking < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  belongs_to :user
  belongs_to :animal
  has_many :reviews, dependent: :destroy

  def overlaps?(other_start, other_end)
    start_date <= other_end && other_start <= end_date
  end
end
