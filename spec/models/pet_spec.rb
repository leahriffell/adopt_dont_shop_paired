require 'rails_helper'

describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
  end
end

  describe "class methods" do
    it "can get number of favorited pets" do
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
                            favorites: true
                          )
      expect(Pet.favorite_count).to eq(1)
    end                   
  end

  describe "instance methods" do 
    it "can change favorites attribute" do
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
                            favorites: false
                          )

      expect(@pet_1.favorites).to eq(false)
      @pet_1.add_to_favorites 
      expect(@pet_1.favorites).to eq(true)
  end
end
