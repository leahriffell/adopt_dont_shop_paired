require 'rails_helper'

RSpec.describe "new review page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
  end
  it "can create new review" do
    visit "/shelters/#{@shelter_1.id}/reviews/new"

    fill_in(:title, with: "Mountains of Love <3!")
    select 5, from: :rating
    fill_in(:content, with: "Super clean, well-facilitated, and healthy pups.")
    fill_in(:optional_picture, with: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg")

    click_button("Add Review")

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Mountains of Love <3!")
    expect(page).to have_content(5)
    expect(page).to have_content("Super clean, well-facilitated, and healthy pups.")
    expect(page).to have_css("img[src*=heart-4]")
  end

  it "can require fields" do
    visit "/shelters/#{@shelter_1.id}/reviews/new"

    click_button("Add Review")

    expect(page).to have_content("Please fill out title, review, and content.")    
    expect(page).to have_button("Add Review")

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/reviews/new")
  end


  it "can add default picture" do
    visit "/shelters/#{@shelter_1.id}/reviews/new"
    
    fill_in(:title, with: "Mountains of Love <3!")
    select 5, from: :rating
    fill_in(:content, with: "Super clean, well-facilitated, and healthy pups.")
    click_button("Add Review")
    
    expect(page).to have_css("img[src$='default_review_image.jpg']")
  end
end
