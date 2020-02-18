class BookingsController < ApplicationController

  def index
    @booking = Booking.all
  end

  def new
    @booking = Booking.new
    @animal = Animal.find(params[:animal_id])
  end

  def create
    @animal = Animal.find(params[:animal_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.animal = @animal
    if @booking.save
      redirect_to(animal_path(@animal))
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:booking_id])
    @booking.destroy
  end

private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
