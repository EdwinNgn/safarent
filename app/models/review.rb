class Review < ApplicationRecord
  attr_accessor :description_animal
  attr_accessor :rating_animal
  attr_accessor :description_owner
  attr_accessor :rating_owner
  attr_accessor :description_renter
  attr_accessor :rating_renter

  belongs_to :booking
  validates :rating, presence: true
  validates :review_type, presence: true, inclusion: { in: %w(owner animal renter)}
  validates :description, presence: true

  def save_all(user_type, booking)
    if user_type == "renter"
      animal_review = Review.new(description: self.description_animal, rating: self.rating_animal, review_type: "animal", booking: booking)
      owner_review  = Review.new(description: self.description_owner,  rating: self.rating_owner,  review_type: "owner", booking: booking)
      if owner_review.valid? && animal_review.valid?
        owner_review.save
        animal_review.save
      else
        false
      end
    else
      renter_review = Review.new(description: self.description_renter, rating: self.rating_renter, review_type: "renter", booking: booking)
      renter_review.save if renter_review.valid?
    end
  end
end
