class AddApprovedApplicantToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :approved_applicant, :string
  end
end
