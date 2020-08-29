class FavoritesController < ApplicationController

  def index
    @fav_pets = Pet.where(id: cart.contents.keys.map {|key| key.to_i })
    @pets = Pet.pets_with_apps
  end
end
