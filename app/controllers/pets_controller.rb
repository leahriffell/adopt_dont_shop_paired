class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
    @pet = Pet.new
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create(pet_params)
    pet.save
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])

    redirect_to "/pets"
  end

  # def favorite
  #   pet = Pet.find(params[:id])
  #   pet.add_to_favorites
  #   flash[:notice] = "Pet has been added to my favorites list."
  #   redirect_to "/pets/#{pet.id}"
  # end

  # def unfavorite
  #   pet = Pet.find(params[:id])
  #   pet.unfavorite
  #   redirect_to '/favorites'
  # end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end
end
