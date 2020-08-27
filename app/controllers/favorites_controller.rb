class FavoritesController < ApplicationController

  def index
    @fav_pets = FavoritesList.pets
  end

  def remove

  end
end
