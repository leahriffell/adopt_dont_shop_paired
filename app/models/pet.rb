class Pet < ApplicationRecord
  belongs_to :shelter

  def self.favorite_pets
    self.where(is_favorite: true)
  end

  def add_to_favorites
    update(is_favorite: true)
  end

  def unfavorite
    update(is_favorite: false)
  end
end
