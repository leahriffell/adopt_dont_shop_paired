require 'rails_helper'

RSpec.describe "show a shelter's pets page", type: :feature do
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
                          adoption_status: "adoptable"
                        )
  end

  it "can see the pets's info" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.adoption_status)
  end

  it "can link to form for updating its attributes" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_link(href: "/pets/#{@pet_1.id}/edit")
  end

  it "can be deleted" do
    visit "/pets/#{@pet_1.id}"

    click_link "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet_1.name)
    # expectation above assumes that shelter names are unique
    expect(page).to_not have_link("Delete Pet")
  end

  it "can be favorited" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_link("Add to Favorites")

    expect(page).to have_no_link("Remove from Favorites")

    click_link "Add to Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Pet has been added to my favorites list.")
    expect(page).to have_content("Favorites(1)")
  end

  it "can be removed from favorites" do
    visit "/pets/#{@pet_1.id}"

    click_link "Add to Favorites"

    expect(page).to have_no_link("Add to Favorites")
    expect(page).to have_link("Remove from Favorites")

    click_link "Remove from Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Pet has been removed from my favorites list.")
    expect(page).to have_content("Favorites(0)")
    expect(page).to have_link("Add to Favorites")
  end

  it "can see link to view all applications for this pet" do
    visit "/pets/#{@pet_1.id}"

    click_link "Applications for #{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}/applications")
  end

  it "cannot cannot delete pet with approved application" do
    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit!",
                          sex: "Male",
                          shelter_id: @shelter_1.id,
                          adoption_status: "Pending"
                        )
    visit "/pets"

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_no_link("Delete Pet")
      expect(page).to have_content("Pet has pending application")
    end
  end
end
