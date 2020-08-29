class FavoritesController < ApplicationController

  def index
    @fav_pets = Pet.where(id: cart.contents.keys.map {|key| key.to_i })
    @pets_with_apps = Pet.pets_with_apps
  end
end
