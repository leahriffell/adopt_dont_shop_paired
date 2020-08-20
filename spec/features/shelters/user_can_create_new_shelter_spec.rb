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
    
    expect(page).to have_current_path("/shelters")
    expect(page).to have_content("Kitty Rescue")
    # how to make this test dynamic?
  end
end
