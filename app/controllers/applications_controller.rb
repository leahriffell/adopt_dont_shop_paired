class ApplicationsController < ApplicationController
  def new
    @fav_pets = cart.favorite_pets.map {|id| Pet.find(id.to_i)}
  end
end