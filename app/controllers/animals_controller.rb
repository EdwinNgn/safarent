class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :destroy, :edit, :update]

  def index
    if params[:search].blank?
      if params[:preferences][:category].blank? && params[:preferences][:price].blank?
        @animals = Animal.geocoded
      elsif !params[:preferences][:category].blank? && params[:preferences][:price].blank?
        animals_in_location = Animal.where("location ILIKE ?", "%#{params[:preferences][:location]}%").geocoded
        @animals = []
        animals_in_location.each do |animal|
          @animals << animal if animal.animal_type == params[:preferences][:category]
        end
      elsif params[:preferences][:category].blank? && !params[:preferences][:price].blank?
        animals_in_location = Animal.where("location ILIKE ?", "%#{params[:preferences][:location]}%").geocoded
        @animals = []
        animals_in_location.each do |animal|
          @animals << animal if animal.price_per_day < params[:preferences][:price].to_i
        end
      else
        animals_in_location = Animal.where("location ILIKE ?", "%#{params[:preferences][:location]}%").geocoded
        @animals = []
        animals_in_location.each do |animal|
          @animals << animal if animal.animal_type == params[:preferences][:category] && animal.price_per_day < params[:preferences][:price].to_i
        end
      end
    elsif params[:search][:location].blank?
      @animals = Animal.geocoded
    else
      @location = params[:search][:location].strip
      @animals  = Animal.where("location ILIKE ?", "%#{@location}%").geocoded
      unless params[:search][:start_date].blank? || params[:search][:end_date].blank?
        @animals = @animals.select do |animal|
          animal.bookable?(params[:search][:start_date].split("to")[0].to_date,params[:search][:end_date].to_date)
        end
      end
    end
    # @animals_geolocations = @animals.geocoded
    @markers = @animals.map do |animal|
      {
        lat: animal.latitude,
        lng: animal.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { animal: animal })
      }
    end

  end

  def show
    @animal = Animal.find(params[:id])
    @booking = Booking.new
    @bookings = Booking.where(animal_id: @animal.id)
    @bookings_dates = @bookings.map do |booking|
      {
        from: booking.start_date,
        to:   booking.end_date
      }
    end

    @average_rate = average_rating_for_animal
    @number_of_comments = number_of_comments
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    @animal.address = "#{params[:animal][:street]}, #{params[:animal][:zipcode]} #{params[:animal][:location]}"
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
    redirect_to profil_path(current_user)
  end

  def average_rating_for_animal
    animal = Animal.find(params[:id])
    sum_ratings = 0
    denominateur = 0
    animal.reviews.each_with_index do |review, index|
      if review[:review_type] == "animal"
        sum_ratings += review[:rating]
        denominateur += 1
      end
    end
    if denominateur != 0
      (sum_ratings / denominateur.to_f).round(1)
    else
      0
    end
  end

  def number_of_comments
    animal = Animal.find(params[:id])
    denominateur = 0
    animal.reviews.each_with_index do |review, index|
      if review[:review_type] == "animal"
        denominateur += 1
      end
    end
    denominateur
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :animal_type, :species, :price_per_day,:street, :zipcode, :location, :description, photos: [])
  end
end
