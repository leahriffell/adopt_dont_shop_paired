require 'rails_helper'

RSpec.describe "edit review page", type: :feature do
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

  end

  it "can edit an existing review" do
    visit "/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit"

    expect(find_field(:title).value).to eq(@review.title)
    expect(find_field(:rating).value).to eq(@review.rating.to_s)
    expect(find_field(:content).value).to eq(@review.content)
    expect(find_field(:optional_picture).value).to eq(@review.optional_picture)

    fill_in(:title, with: "Mountains of Love <3 <3!")

    click_button("Update Review")

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Mountains of Love <3 <3!")
  end

  it "can add default picture" do
    visit "/shelters/#{@shelter_1.id}/reviews/#{@review.id}/edit"

    fill_in(:optional_picture, with: "")

    click_button("Update Review")

    expect(page).to have_css("img[src*=default_review_image]")
    #I just removed the .jpg, change the $ to a * and removed the inner ''.
  end
end
