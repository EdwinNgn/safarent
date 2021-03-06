class Animal < ApplicationRecord
  validates :name, presence: true
  validates :animal_type, presence: true
  validates :price_per_day, presence: true
  validates :location, presence: true
  validates :species, presence: true
  validates :description, presence: true
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  geocoded_by :address, length: { minimum: 0, allow_nil: true}
  after_validation :geocode, if: :will_save_change_to_address?

  def bookable?(start_date,end_date)
    bookings.each do |booking|
      return false if booking.overlaps?(start_date,end_date)
    end
    return true
  end

  def stars_number_to_display
    sum_ratings = 0
    denominateur = 0
    self.reviews.each do |review|
      sum_ratings += review[:rating]
      denominateur += 1
    end
    if denominateur != 0
      sum_ratings / denominateur
    else
      0
    end
  end

end
