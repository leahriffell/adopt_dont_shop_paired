class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def self.pets_with_apps
    Pet.joins(:applications)
  end

  def has_apps
    applications.count > 0
  end

  def change_to_pending
    update(adoption_status: "Pending")
  end

  def has_approved_applicant
    approved_applicant != nil
  end
end
