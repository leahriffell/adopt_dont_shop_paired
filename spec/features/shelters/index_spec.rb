require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do 
  before :each do
    @shelter_1 = Shelter.create!(id: 1,
                                name: "Rocky Mountain Puppy Rescue",
                                address: "10021 E Iliff Ave",
                                city: "Aurora",
                                state: "CO",
                                zip: "80247"
                                )
    
    @shelter_2 = Shelter.create!(id: 2,
                                name: "Espiritu Alpacas",
                                address: "8221 S Blue Creek Rd",
                                city: "Evergreen",
                                state: "CO",
                                zip: "80439"
                                )
  end

  it "can see all shelters' names" do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "can can show one shelter" do
    visit "/shelters"

    expect(page).to have_link(href: "/shelters/1")
    # better practice to just do /shelters/#{@shelter_1.id}?
    expect(page).to have_link(href: "/shelters/2")
  end

  it "can link to form for creating a new shelter" do
    visit "/shelters"

    expect(page).to have_link(href: "/shelters/new")
  end
end