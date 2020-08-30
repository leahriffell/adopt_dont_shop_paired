require 'rails_helper'

describe 'application pets index' do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
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

    @pet_2.applications << @application
  end 

  it 'link to names of all applicants applications show page' do

    visit "/pets/#{@pet_2.id}/applications"

    expect(page).to have_link("#{@application.name}")

    click_link "#{@application.name}"

    expect(page).to have_current_path("/applications/#{@application.id}")
  end

end
