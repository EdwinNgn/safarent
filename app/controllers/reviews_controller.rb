class ReviewsController < ApplicationController
  def index
    @review = Review.all
  end

  def new
    @booking  = Booking.find(params[:booking_id])
    @review   = Review.new
    @reviewer = (current_user == @booking.user ? "renter" : "owner")
  end

  def create
    @review   = Review.new(review_params)
    @booking  = Booking.find(params[:booking_id])
    @reviewer = (current_user == @booking.user ? "renter" : "owner")

    if @review.save_all(@reviewer, @booking)
      redirect_to animal_path(@booking.animal)
    else
      render :new
    end
  end

private

  def review_params
    params.require(:review).permit(:description_animal,
                                   :description_owner,
                                   :description_renter,
                                   :rating_animal,
                                   :rating_owner,
                                   :rating_renter)
  end

  def set_up_review(user)
    if user == current_user
      @review_owner = Review.new(review_owner_params)
      @review_animal = Review.new(review_animal_params)

    else
    end
  end
end
