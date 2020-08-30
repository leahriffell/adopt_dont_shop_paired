class ApplicationPetsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
    @applications = @pet.applications
  end
end
