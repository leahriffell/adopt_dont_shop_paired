class FavoritesList < ApplicationRecord
  def self.num_of_pets
    Pet.favorite_pets.count
  end

  def self.pets
    Pet.favorite_pets
  end
  
end
