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
    if !pet.save
      error_message
      redirect_to "/shelters/#{shelter.id}/pets/new"
    else
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if !pet.save
      error_message
      redirect_to "/pets/#{pet.id}/edit"
    else
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.has_apps
      Application.find(pet.application_pets[0].application_id).pets.delete(pet)
    end
    Pet.destroy(params[:id])
    cart.remove_pet(pet.id)
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
      if pet.has_approved_applicant
        pet.update(approved_applicant: nil)
        pet.change_to_adoptable
        redirect_to "/applications/#{application_id}"
      else
        pet.update(approved_applicant: approved_applicant_name)
        pet.change_to_pending
        redirect_to "/pets/#{pet.id}"
      end
    end
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end

  def error_message
    messages = []
    messages << "name" if params[:name].empty?
    messages << "image" if params[:image].empty?
    messages << "description" if params[:description].empty?
    messages << "age" if params[:approximate_age].empty?
    messages << "sex" if params[:sex].empty?
    flash[:error] = "Please fill in: #{messages.join(", ")}"
  end
end
