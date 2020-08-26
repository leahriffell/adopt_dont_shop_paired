class Pet < ApplicationRecord
  belongs_to :shelter
  def self.favorite_count
    self.where(favorites: true).count 
  end
end
