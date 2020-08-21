class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show 
    @pet = Pet.find(params[:id])
  end

  def new 
    @pet = Pet.new
    @shelter = Shelter.find(params[:id])
  end

  def create 
    shelter = Shelter.find(params[:id])

    pet = Pet.new({
      name: params[:name],
      description: params[:description],
      approximate_age: params[:approximate_age],
      sex: params[:sex],
      shelter_id: shelter.id,
      adoption_status: "Adoptable"
    })

    pet.save

    redirect_to "/shelters/#{shelter.id}/pets"
  end
end