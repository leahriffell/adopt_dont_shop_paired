class ApplicationsController < ApplicationController
  def new
    # @fav_pet_ids = cart.favorite_pets.map {|id| id.to_i}
    @fav_pets = cart.favorite_pets.map {|id| Pet.find(id.to_i)}
  end
end