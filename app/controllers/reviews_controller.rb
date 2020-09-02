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
    if review.save && has_picture
      redirect_to "/shelters/#{shelter.id}"
    elsif review.save && !has_picture
      review.update(optional_picture: default_picture)
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Please fill out title, review, and content."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    if !has_picture 
      review.update(optional_picture: default_picture)
    end
    # review.save
    redirect_to "/shelters/#{review.shelter_id}"
  end

  def destroy 
    review = Review.find(params[:id])
    shelter_id = review.shelter_id
    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
  end

  def has_picture
    params[:optional_picture] != ""
  end

  def default_picture 
    "default_review_image.jpg"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :optional_picture)
  end
end
