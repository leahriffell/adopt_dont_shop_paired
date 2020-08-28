require 'rails_helper'

RSpec.describe "application", type: :feature do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )

    @pet_1 = Pet.create!(
                          image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                          name: "Fluffy",
                          approximate_age: "15 weeks",
                          sex: "Female",
                          shelter_id: @shelter_1.id,
                        )
  end

  it 'has navigation bar' do

    visit "/"

    within('nav') do
      expect(page).to have_link("Pets")
      expect(page).to have_link("Shelters")
      expect(page).to have_link("Favorites(0)")
    end
  end

end
