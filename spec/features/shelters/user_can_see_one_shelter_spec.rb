require 'rails_helper'

RSpec.describe "show shelter by id page", type: :feature do
  before :each do 
    @shelter_1 = Shelter.create(id: 1,
    # is adding the id num above what I should be doing? 
    name: "Rocky Mountain Puppy Rescue",
    address: "10021 E Iliff Ave",
    city: "Aurora",
    state: "CO",
    zip: "80247")
  end

  it "can see the shelter's name and address" do
    visit "/shelters/1"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "can link back to shelter index" do
    visit "/shelters/1"

    expect(page).to have_link(href: "/shelters")
  end

  it "can link to form for updating its attributes" do
    visit "/shelters/1"

    expect(page).to have_link(href: "/shelters/1/edit")
  end

  it "has link for deleting the it" do
    visit "/shelters/1"

    expect(page).to have_content("Delete Shelter")
  end
end