require 'rails_helper'

RSpec.describe "new pet page", type: :feature do 
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
  end

  it "can create new shelter pet" do
    visit "/shelters/#{@shelter_1.id}/pets/new"
    
    # test photo upload https://i.redd.it/vdyzuidpq8c01.jpg
    fill_in(:name, with: "Perla")
    fill_in(:description, with: "I love skittles!")
    fill_in(:approximate_age, with: "5 months")
    fill_in(:sex, with: "Female")
    click_button("Add Pet")
    
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_content("Perla")
    expect(page).to have_content("5 months")
    expect(page).to have_content("Female")
    # how to make this test dynamic?
  end
end