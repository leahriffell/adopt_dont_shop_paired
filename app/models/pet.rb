class Pet < ApplicationRecord
  belongs_to :shelter

  def self.favorite_pets
    self.where(is_favorite: true)
  end
end
