require 'rails_helper'

RSpec.describe 'favorites index page' do
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
                          description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                          adoption_status: "adoptable",
                          favorites: true
                        )
  end

  it 'see all pets favorited' do

    visit '/favorites'

    within ".pet#{@pet_1.id}" do
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    end
  end

  it 'can see pet show page when clicked on' do

    visit '/favorites'

    click_link 'Fluffy'

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

end
