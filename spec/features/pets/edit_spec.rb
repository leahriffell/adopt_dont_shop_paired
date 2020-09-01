require 'rails_helper'

RSpec.describe "edit pet page", type: :feature do
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

  it "can create edit a pet's attributes" do
    visit "/pets/#{@pet_1.id}/edit"

    expect(find_field(:name).value).to eq "Fluffy"
    expect(find_field(:image).value).to eq "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg"
    expect(find_field(:description).value).to eq "I am fluffy and so cute. I need someone to be my friend forever!!"
    expect(find_field(:approximate_age).value).to eq "15 weeks"
    expect(find_field(:sex).value).to eq "Female"

    fill_in(:name, with: "Fluffball")
    fill_in(:approximate_age, with: "17 weeks")
    click_button("Update Pet")

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    expect(page).to have_content("Fluffball")
    expect(page).to have_content("17 weeks")

    visit "/pets/"
    expect(page).to have_content("Fluffball")
    expect(page).to have_content("17 weeks")
  end

  it "can display error message for missing fields" do
    visit "/pets/#{@pet_1.id}/edit"
    fill_in(:name, with: "")
    click_button("Update Pet")
    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")
    expect(page).to have_content("Please fill in: name")
  end
end
