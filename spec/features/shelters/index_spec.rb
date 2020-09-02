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
    @pet_1 = @shelter_1.pets.create!(
                                    image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                                    name: "Fluffy",
                                    approximate_age: "15 weeks",
                                    sex: "Female",
                                    description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                                    adoption_status: "Adoptable",
                                    approved_applicant: nil
                                  )

    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit!",
                          sex: "Male",
                          shelter_id: @shelter_2.id,
                          adoption_status: "Pending",
                          approved_applicant: "Dani Coleman"
                        )

    @application = @pet_2.applications.create!(
                                name: "Dani Coleman",
                                address: "123 Road Dr.",
                                city: "Arvada",
                                state: "CO",
                                zip: "80005",
                                phone_number: "555-555-5555",
                                description: "I love animals!!!!!"
                              )
    
    @review_1 = @shelter_1.reviews.create!(
      title: "Mountains of Love <3!",
      rating: 5,
      content: "Super clean, well-facilitated, and healthy pups.",
      optional_picture: "https://static.boredpadnda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg",
    )
  end

  it "can see all shelters' names" do
    visit "/shelters"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "can can link to one shelter" do
    visit "/shelters"
    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}")
    expect(page).to have_link(href: "/shelters/#{@shelter_2.id}")
  end

  it "can link to form for creating a new shelter" do
    visit "/shelters"
    expect(page).to have_link(href: "/shelters/new")
  end

  it "can link to form for editing each shelter" do
    visit "/shelters"
    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit")
  end

  it "can delete each shelter" do
    visit "/shelters"

    within("#shelter-#{@shelter_1.id}") do
      click_link "Delete Shelter"
    end
    expect(current_path).to eq("/shelters")
    expect(page).to have_no_content(@shelter_1.name)
  end

  it "can only delete shelters with no pending applications" do
    visit "/shelters"

    within("#shelter-#{@shelter_2.id}") do
      expect(page).to have_no_link("Delete Shelter")
      expect(page).to have_content("Shelter has pending applications")
    end
  end

  it "can delete all pets at shelter when shelter is deleted" do
    visit "/shelters"

    within("#shelter-#{@shelter_1.id}") do 
      click_link "Delete Shelter"
    end

    visit "/pets"
    expect(page).to have_no_content(@pet_1.name)
  end

  it "can show top 3 ranking shelters in special section" do 
    visit "/shelters"

    within(".top-shelters") do
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_no_content("#{@shelter_2.name}")
    end
  end
end
