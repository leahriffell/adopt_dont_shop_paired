class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :name
  validates_presence_of :image
  validates_presence_of :description
  validates_presence_of :approximate_age
  validates_presence_of :sex

  def self.pets_with_apps
    Pet.joins(:applications)
  end

  def has_apps
    applications.count > 0
  end

  def is_pending
    adoption_status == "Pending"
  end

  def change_to_pending
    update(adoption_status: "Pending")
  end

  def has_approved_applicant
    approved_applicant != nil
  end

  def change_to_adoptable
    update(adoption_status: "Adoptable")
  end

  def delete_pet_and_associations(pet, cart)
    if pet.has_apps
      Application.find(pet.application_pets[0].application_id).pets.delete(pet)
    end
    cart.remove_pet(pet.id)
    Pet.destroy(pet.id)
  end
end
