class ReviewsController < ApplicationController
  def index
    @review = Review.all
  end

  def new
    @review = Review.new
    @booking = Booking.find(params[:booking_id])
    @reviews_types = current_user == @booking.user ? ["owner", "animal"] : ["renter"]
  end

  def create
    @review = Review.new
    @booking = Booking.find(params[:booking_id])
    @reviews_types = current_user == @booking.user ? ["owner", "animal"] : ["renter"]
    reviews = []
    @reviews_types.each do |review_type|
      review = Review.new(review_params(params[:review][review_type]))
      review.booking = @booking
      reviews << review
    end
    if reviews.all? { |review| review.valid?}
      reviews.each { |review| review.save}
      redirect_to animal_path(@booking.animal)
    else
      render :new
    end
  end

private

  def review_params(my_params)
   my_params.permit(:description, :rating, :review_type)
  end

  def set_up_review(user)
    if user == current_user
      @review_owner = Review.new(review_owner_params)
      @review_animal = Review.new(review_animal_params)

    else
    end
  end
end
