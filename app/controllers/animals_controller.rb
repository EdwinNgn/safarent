class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :destroy, :edit, :update]

  def index
    if params[:search].blank?
      @animals = Animal.all
    else
      @location = params[:search][:location].blank? ?  "Lille" : params[:search][:location]
      if params[:search][:start_date].blank? || params[:search][:end_date].blank?
        @animals = Animal.where(location: @location)
      else
        animals_in_location = Animal.where(location: @location)
        @animals = []
        animals_in_location.each do |animal|
          @animals << animal if animal.bookable?(params[:search][:start_date].to_date,params[:search][:end_date].to_date)
        end
      end
    end

  end

  def show
    @animal = Animal.find(params[:id])
    @booking = Booking.new
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.user = current_user
    if @animal.save
      redirect_to animal_path(@animal)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @animal.update(animal_params)
    redirect_to animal_path(@animal)
  end

  def destroy
    @animal.destroy
    redirect_to animals_path
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :animal_type, :species, :price_per_day, :location, :description, photos: [])
  end
end
