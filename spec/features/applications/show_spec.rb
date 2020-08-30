require 'rails_helper'

describe 'application show page' do
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
    @application = Application.create!(
                          name: "Dani Coleman",
                          address: "123 Road Dr.",
                          city: "Arvada",
                          state: "CO",
                          zip: "80005",
                          phone_number: "555-555-5555",
                          description: "I love animals!!!!!"
                        )

    @pet_1.applications << @application
    @pet_2.applications << @application
  end

  it 'can see application with all fields and name of pets' do

    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.phone_number)
    expect(page).to have_content(@application.description)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
    click_link "Fluffy"
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it 'see a link to approve the application for that specific pet' do

    visit "/applications/#{@application.id}"

    within "#pet_on_app-#{@pet_1.id}" do
      expect(page).to have_button("Approve")
      click_button "Approve for #{@pet_1.name}"
      expect(page).to have_current_path("/pets/#{@pet_1.id}")
      rescue Selenium::WebDriver::Error::StaleElementReferenceError
        sleep 1
        retry
      expect(page).to have_content("Adoption status: Pending")
      expect(page).to have_content("On hold for Dani Coleman")
    end
  end

  it 'can approve multiple pets at once' do 

    visit "/applications/#{@application.id}"

    within "#select_multiple" do
      expect(page).to have_button("Approve")
      select "Fluffy", from: "Pet names"
      select "Turquoise", from: "Pet names"
      click_button "Approve"
      expect(page).to have_current_path("/applications/#{@application.id}")
    end
    
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("On hold for Dani Coleman")
  end
end
