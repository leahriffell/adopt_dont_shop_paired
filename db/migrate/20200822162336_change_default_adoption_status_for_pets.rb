class ChangeDefaultAdoptionStatusForPets < ActiveRecord::Migration[5.2]
  def change
    change_column_default :pets, :adoption_status, from: nil, to: "Adoptable"
  end
end