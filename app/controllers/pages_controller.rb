class PagesController < ApplicationController
  def home
    @animals = Animal.all.map{ |animal| animal.location}.uniq
  end
end
