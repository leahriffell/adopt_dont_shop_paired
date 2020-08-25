class ReviewsController < ApplicationController
  def index
  end

  def new
    @shelter = Shelter.find(params[:id])
    @review = Review.new
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.create(review_params)
    review.save

    redirect_to "/shelters/#{shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :optional_picture)
  end
end
