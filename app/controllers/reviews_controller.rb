class ReviewsController < ApplicationController
  def index 
  end

  def create 
    shelter = Shelter.find(params[:id])
    require 'pry'; binding.pry
    review = shelter.reviews.create(review_params)
    review.save
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :optional_picture)
  end
end