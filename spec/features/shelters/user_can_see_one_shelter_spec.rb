require 'rails_helper'

RSpec.describe "show shelter by id page", type: :feature do
  before :each do 
    @shelter_1 = Shelter.create!(
                                name: "Rocky Mountain Puppy Rescue",
                                address: "10021 E Iliff Ave",
                                city: "Aurora",
                                state: "CO",
                                zip: "80247"
                              )
  end

  it "can see the shelter's name and address" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "can link back to shelter index" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters")
  end

  it "can link to form for updating its attributes" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit")
  end

  it "can be deleted" do
    visit "/shelters/#{@shelter_1.id}"
    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")    
    expect(page).to_not have_content(@shelter_1.name)
    # expectation above assumes that shelter names are unique
    expect(page).to_not have_link("Delete Shelter")
    
  end
end