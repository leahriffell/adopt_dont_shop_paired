class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  def self.top_three
    avg_ratings = Shelter.select('shelters.*, reviews.*').joins(:reviews).group(:id).average(:rating)

    avg_ratings_sorted = avg_ratings.sort_by {|shelter, avg_rating| -avg_rating}[0..2]

    avg_ratings_sorted.map {|shelter, avg_rating| Shelter.find(shelter)}
  end

  def has_reviews
    reviews.count > 0
  end

  def avg_rating
    if has_reviews
      reviews.average(:rating)
    else
      "No reviews yet"
    end
  end

  def has_pending_apps
    pets.select {|pet| pet.is_pending}.count != 0
  end

  def count_of_apps
    applications = []
    pets.each {| pet| applications << pet.applications}
    applications.flatten.uniq.count
  end

  def delete_shelter_and_associations(shelter_id, cart)
    pets.each {|pet| pet.delete_pet_and_associations(pet, cart)}
    reviews.each {|review| Review.destroy(review.id)}
    Shelter.destroy(shelter_id)
  end
end
