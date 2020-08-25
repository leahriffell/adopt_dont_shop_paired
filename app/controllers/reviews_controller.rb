class ReviewsController < ApplicationController
  def index
  end

  def new
    @shelter = Shelter.find(params[:id])
    @review = @shelter.reviews.new
  end

  def create
    shelter = Shelter.find(params[:id])
    review = shelter.reviews.create(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Please fill out title, review, and content."
      redirect_to "/shelters/#{shelter.id}/add_review"
      # render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    # require "pry"; binding.pry
    review.save
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :optional_picture)
  end
end
