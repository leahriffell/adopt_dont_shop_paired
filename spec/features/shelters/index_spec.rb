require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do 
  it "can see all shelters' names" do
    shelter_1 = Shelter.create(name: "Rocky Mountain Puppy Rescue",
                               address: "10021 E Iliff Ave",
                               city: "Aurora",
                               state: "CO",
                               zip: "80247")
    
    shelter_2 = Shelter.create(name: "Espiritu Alpacas",
                               address: "8221 S Blue Creek Rd",
                               city: "Evergreen",
                               state: "CO",
                               zip: "80439")

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end
end