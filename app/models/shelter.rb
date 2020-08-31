class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def avg_rating
    reviews.average(:rating)
  end

  def has_pending_apps
    pets.select {|pet| pet.has_apps}.count != 0
  end
end
