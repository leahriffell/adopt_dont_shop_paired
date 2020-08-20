require 'rails_helper'

RSpec.describe "pets index page", type: :feature do 
  before :each do
    @pet_1 = Pet.create!(
          
                        )
    
    @pet_2 = Pet.create!(
  end

  it "can see all pets and their info" do
    visit "/pets"

    expect(page).to have_content(@pet_1. blah blah blah 
  end