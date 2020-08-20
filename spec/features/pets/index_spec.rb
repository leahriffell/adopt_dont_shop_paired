require 'rails_helper'

RSpec.describe "pets index page", type: :feature do 
  before :each do
    @pet_1 = Pet.create!(
                          image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                          name: "Fluffy",
                          approximate_age: "15 weeks",
                          sex: "Female"
                        )
    
    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          sex: "Male"
                        )
  end

  it "can see all pets and their info" do
    visit "/pets"

    expect(page).to have_content(@pet_1.image)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_2.image)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.approximate_age)
    expect(page).to have_content(@pet_2.sex)
  end
end