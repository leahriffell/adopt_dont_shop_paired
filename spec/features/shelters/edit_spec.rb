require 'rails_helper'

RSpec.describe "edit shelter page", type: :feature do 
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
  end

  it "can create edit a shelter's attributes" do
    visit "/shelters/#{@shelter_1.id}/edit"

    expect(find_field("Name").value).to eq "Rocky Mountain Puppy Rescue"
    expect(find_field("Address").value).to eq "10021 E Iliff Ave"
    expect(find_field("City").value).to eq "Aurora"
    expect(find_field("State").value).to eq "CO"
    expect(find_field("Zip").value).to eq "80247"
    
    fill_in(:name, with: "Rocky Mtn Puppy Rescue")
    fill_in(:city, with: "Evergreen")
    click_button("Update Shelter")

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Rocky Mtn Puppy Rescue")
    expect(page).to have_content("Evergreen")

    visit "/shelters/"
    expect(page).to have_content("Rocky Mtn Puppy Rescue")
  end

  it "can require fields" do
    visit "/shelters/#{@shelter_1.id}/edit"

    fill_in(:name, with: "")

    click_button("Update Shelter")

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
    expect(page).to have_content("Please fill out all fields.")    
    expect(page).to have_button("Update Shelter")
  end
end
