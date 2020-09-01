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
                        )

    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit",
                          sex: "Male",
                          shelter_id: @shelter_1.id,
                          adoption_status: "Pending"
                        )

    @application = @pet_1.applications.create!(
                          name: "Dani Coleman",
                          address: "123 Road Dr.",
                          city: "Arvada",
                          state: "CO",
                          zip: "80005",
                          phone_number: "555-555-5555",
                          description: "I love animals!!!!!"
                        )
  end

  it 'can see all pets favorited' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    within "#pet#{@pet_1.id}" do
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    end
  end

  it 'can see pet show page when clicked on' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    within "#pet#{@pet_1.id}" do
      click_link 'Fluffy'
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it 'can remove pet from favorites' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    within("#pet#{@pet_1.id}")  do
      expect(page).to have_link("Remove from Favorites")
      click_link "Remove from Favorites"
    end

    expect(page).to have_current_path('/favorites')

    within('#fav_pets') do
      expect(page).to have_no_content(@pet_1.name)
    end

    within('nav') do
      expect(page).to have_link("Favorites(0)")
    end
  end

  it 'see text saying I have no favorited pets' do

    visit '/favorites'

    expect(page).to have_content('No Furry Friends Here Yet')
  end

  it 'can remove all from favorited pets' do
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit '/favorites'

    expect(page).to have_link("Remove all from favorites")

    click_link "Remove all from favorites"

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content('No Furry Friends Here Yet')
    expect(page).to have_no_link("Remove all from favorites")
    expect(page).to have_link("Favorites(0)")
  end

  it 'can see link for adopting favorite pets' do
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit '/favorites'
    expect(page).to have_link("Apply to adopt")
    click_link "Apply to adopt"
    expect(page).to have_current_path("/applications/new")
  end

  it 'see a section on the page that has a list of all of the pets that have at least one application' do
    visit '/favorites'

    within("#pet_apps") do
      expect(page).to have_link(@pet_1.name)
    end
  end

  it 'can be removed when a pet is deleted' do
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"
    click_link "Delete Pet"
    visit '/favorites'
    expect(page).to have_no_content(@pet_1.name)
    expect(page).to have_link("Favorites(0)")
  end
end
