class AnimalsController < ApplicationController
  def index
    @animals = Animal.all
  end

  def show
    id = params[:id]
    @animal = Animal.find(id)
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
    id = params[:id]
    @animal = Animal.find(id)
  end

  def update
    id = params[:id]
    @animal = Animal.find(id)
    @animal.update(animal_params)
    redirect_to animal_path(@animal)
  end

  def destroy
  end

  private
  def animal_params
    params.require(:animal).permit(:name, :animal_type, :species, :price_per_day, :location, :description)
  end
end
