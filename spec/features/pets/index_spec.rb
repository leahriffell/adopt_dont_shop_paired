require 'rails_helper'

RSpec.describe "pets index page", type: :feature do 
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
    
    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          sex: "Male",
                          shelter_id: @shelter_1.id
                        )
  end


  it "can see all pets and their info" do
    visit "/pets"

    expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.shelter.name)
    
    expect(page).to have_css("img[src*='https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg']")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.approximate_age)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_content(@pet_2.shelter.name)
  end
end