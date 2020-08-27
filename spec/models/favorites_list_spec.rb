require 'rails_helper'

describe FavoritesList, type: :model do
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
                          is_favorite: true
                        )
  end
  describe 'class methods' do
    it 'can get number of favorited pets' do
      expect(FavoritesList.num_of_pets).to eq(1)
    end
    it 'can get favorited pets' do
      expect(FavoritesList.pets).to eq([@pet_1])
    end
  end
end
