require 'rails_helper'

RSpec.describe "shelters show by id page", type: :feature do 
  it "can see all shelter's name and address" do
    shelter_1 = Shelter.create(name: "Rocky Mountain Puppy Rescue",
                               address: "10021 E Iliff Ave",
                               city: "Aurora"
                               state: "CO"
                               zip: "80247")

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)
  end
end