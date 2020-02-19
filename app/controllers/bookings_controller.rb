class BookingsController < ApplicationController

  def index
    @animal = Animal.find(params[:animal_id])
    @bookings = Booking.where(animal:@animal).all
  end

  def new
    @booking = Booking.new
    @animal = Animal.find(params[:animal_id])
  end

  def create
    @animal = Animal.find(params[:animal_id])
    @booking = Booking.new(booking_params)
    start_date = Date.new(booking_params["start_date(1i)"].to_i,booking_params["start_date(2i)"].to_i,booking_params["start_date(3i)"].to_i)
    end_date = Date.new(booking_params["end_date(1i)"].to_i,booking_params["end_date(2i)"].to_i,booking_params["end_date(3i)"].to_i)
    @booking.user = current_user
    @booking.animal = @animal
    if @animal.bookable?(start_date,end_date)
      @booking.save
      redirect_to(booking_path(@booking))
    else
      render 'animals/show'
    end
  end

  def show
    @booking = Booking.find(params[:id])
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
