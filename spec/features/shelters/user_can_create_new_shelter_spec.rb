require 'rails_helper'

RSpec.describe "new shelter page", type: :feature do 
  it "can create new shelter" do
    visit "/shelters/new"
    
    fill_in(:name, with: "Kitty Rescue")
    fill_in(:address, with: "123 Whisker Lane")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "CO")
    fill_in(:zip, with: "80202")

    click_button("Add Shelter")

    expect(Shelter.last.name == "Kitty Rescue")
    # how to make this test (and final test in this block) dynamic? 

    expect(page).to have_current_path("/shelters")
    expect(page).to have_content("Kitty Rescue")
  end
end
