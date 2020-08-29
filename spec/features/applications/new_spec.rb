require 'rails_helper'

RSpec.describe "new application page", type: :feature do 
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
    
    @pet_1 = @shelter_1.pets.create!(
                          image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                          name: "Fluffy",
                          approximate_age: "15 weeks",
                          sex: "Female",
                          description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                          adoption_status: "adoptable"
                        )

    @pet_2 = @shelter_1.pets.create!(
                                      image: "https://qph.fs.quoracdn.net/main-qimg-775e3ef3258895374fcd610163d8c8e3",
                                      name: "Turquoise",
                                      approximate_age: "1 year",
                                      sex: "Male",
                                      description: "I am looking for green pastures to roam and play in.",
                                      adoption_status: "adoptable"
                                    )    
                                          
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{@pet_2.id}"
    click_link "Add to Favorites"
  end

  it 'can see favorited pets in dropdown' do
    visit '/applications/new'

    expect(page).to have_select(:pet_names, :options => ["#{@pet_1.name}", "#{@pet_2.name}"])
  end

  it 'can submit new application' do
    visit '/applications/new'
    select "Fluffy", from: "Pet names"

    fill_in(:name, with: "Dani")
    fill_in(:address, with: "123 Road Dr.")
    fill_in(:city, with: "Arvada")
    fill_in(:state, with: "CO")
    fill_in(:zip, with: "80005")
    fill_in(:phone_number, with: "555-555-5555")
    fill_in(:description, with: "I love animals!!!!!")

    click_button("Submit Application")

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content('Your application has been submitted for selected pets')
    expect(page).to have_no_content(@pet_1.name)
  end
end