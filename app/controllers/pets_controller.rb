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

  def change_application_status
    approved_applicant_name = Application.find(params[:approved_applicant]).name
    application_id = Application.find(params[:approved_applicant]).id
    if params[:pet_names]
      pets = Pet.find(params[:pet_names])
      pets.each do |pet|
        pet.update(approved_applicant: approved_applicant_name)
        pet.change_to_pending
      end
      redirect_to "/applications/#{application_id}"
    else 
      pet = Pet.find(params[:id])
      pet.update(approved_applicant: approved_applicant_name)
      pet.change_to_pending
      redirect_to "/pets/#{pet.id}"
    end
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end
end
