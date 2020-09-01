require 'rails_helper'

RSpec.describe "show shelter by id page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
    @review = @shelter_1.reviews.create!(
                                  title: "Mountains of Love <3!",
                                  rating: 5,
                                  content: "Super clean, well-facilitated, and healthy pups.",
                                  optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg",
                                )
    @pet_1 = Pet.create!(
                        image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                        name: "Fluffy",
                        approximate_age: "15 weeks",
                        sex: "Female",
                        shelter_id: @shelter_1.id,
                        description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                        adoption_status: "adoptable"
                      )

    @application_1 = @pet_1.applications.create!(
                                  name: "Paul Bunyan",
                                  address: "12 Big Tree Ln",
                                  city: "Alachua",
                                  state: "TX",
                                  zip: "95743",
                                  phone_number: "1234567890",
                                  description: "My trusty Blue Ox is retired. Looking for my forever logging partner!"
                                )

    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit!",
                          sex: "Male",
                          shelter_id: @shelter_1.id,
                          adoption_status: "Adoptable",
                          approved_applicant: nil
                        )
    @application_2 = @pet_2.applications.create!(
                                  name: "Dani Coleman",
                                  address: "123 Road Dr.",
                                  city: "Arvada",
                                  state: "CO",
                                  zip: "80005",
                                  phone_number: "555-555-5555",
                                  description: "I love animals!!!!!"
                                )
  end

  it "can see the shelter's name and address" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "can link back to shelter index" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters")
  end

  it "can link to form for updating its attributes" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit")
  end

  it "can link to all of its pets" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/pets")
  end

  it "can be deleted" do
    visit "/shelters/#{@shelter_1.id}"

    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
    # expectation above assumes that shelter names are unique
  end

  it "can see list of reviews" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@review.title)
    expect(page).to have_content(@review.rating)
    expect(page).to have_content(@review.content)
    expect(page).to have_css("img[src*=heart-4]")
  end

  it "can still render a review without an image" do
    @review_2 = @shelter_1.reviews.create!(
                                            title: "meh",
                                            rating: 2,
                                            content: "it was weird."
                                          )

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_2.content)
  end

  it "can see a link to add a new review" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/reviews/new")

    click_link "Add Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
  end

  it "can see a link to edit review" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit")

    click_link "Edit Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit")
  end

  it "can delete a review" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_link("Delete Review")

    click_link "Delete Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to_not have_content(@review.title)
    expect(page).to_not have_link("Delete Review")
  end

  it "can see average review rating" do
    @review_2 = @shelter_1.reviews.create!(
                                          title: "meh",
                                          rating: 2,
                                          content: "it was weird."
                                        )

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content("Average rating: #{@shelter_1.avg_rating}")
  end

  it "shelter cannot be deleted with pending applications" do
    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit!",
                          sex: "Male",
                          shelter_id: @shelter_1.id,
                          adoption_status: "Pending",
                          approved_applicant: "Paul Bunyan"
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

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_no_link("Delete Shelter")
    expect(page).to have_content("Shelter has pending applications")
  end

  it "can get count of applications for that shelter" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Applications on File: 2")
  end

end
