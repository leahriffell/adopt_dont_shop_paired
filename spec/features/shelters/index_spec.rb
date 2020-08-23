require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do 
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
    
    @shelter_2 = Shelter.create!(
                                  name: "Espiritu Alpacas",
                                  address: "8221 S Blue Creek Rd",
                                  city: "Evergreen",
                                  state: "CO",
                                  zip: "80439"
                                )
    
    visit "/shelters"
  end

  it "can see all shelters' names" do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "can can link to one shelter" do
    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}")
    expect(page).to have_link(href: "/shelters/#{@shelter_2.id}")
  end

  it "can link to form for creating a new shelter" do
    expect(page).to have_link(href: "/shelters/new")
  end

  it "can link to form for editing each shelter" do
    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit")
  end

  it "can delete each shelter" do
    first(".delete-shelter").click

    expect(current_path).to eq("/shelters")    
    expect(page).to_not have_content(@shelter_1.name)
  end
end