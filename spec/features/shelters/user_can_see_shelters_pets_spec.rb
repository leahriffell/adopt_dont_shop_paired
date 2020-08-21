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
                          shelter_id: @shelter_1.id
                        )
  end

  it "can see all pets at a shelter" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
  end

  it "can link to form for creating a new pet at shelter" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/new")
  end
end