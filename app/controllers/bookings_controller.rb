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
    start_date = booking_params[:start_date].split("to")[0].to_date
    end_date = booking_params[:end_date].to_date
    @booking = Booking.new(start_date: start_date, end_date: end_date)
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
