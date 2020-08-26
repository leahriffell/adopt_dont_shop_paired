class Pet < ApplicationRecord
  belongs_to :shelter

  def self.favorite_pets
    self.where(favorites: true)
  end

  def add_to_favorites
    update(favorites: true)
  end
end
