require 'rails_helper'

describe Pet, type: :model do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )

    @pet_1 = @shelter_1.pets.create!(
                          image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                          name: "Fluffy",
                          approximate_age: "15 weeks",
                          sex: "Female",
                          description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                          adoption_status: "adoptable",
                        )

    @pet_2 = @shelter_1.pets.create!(
                                  image: "https://qph.fs.quoracdn.net/main-qimg-775e3ef3258895374fcd610163d8c8e3",
                                  name: "Turquoise",
                                  approximate_age: "1 year",
                                  sex: "Male",
                                  description: "I am looking for green pastures to roam and play in.",
                                  adoption_status: "adoptable"
                                    )
    @application = @pet_1.applications.create!(
                          name: "Dani Coleman",
                          address: "123 Road Dr.",
                          city: "Arvada",
                          state: "CO",
                          zip: "80005",
                          phone_number: "555-555-5555",
                          description: "I love animals!!!!!"
                        )
  end

  describe 'relationships' do
    it { should belong_to :shelter }
    it { should have_many :application_pets }
    it {should have_many(:applications).through(:application_pets)}
  end

  describe 'class method' do
    it 'can get all pets with applications' do
      expect(Pet.pets_with_apps).to eq([@pet_1])
    end
  end

  describe 'instance method' do
    it "can see applications exist" do
      expect(@pet_1.has_apps).to eq(true)
      expect(@pet_2.has_apps).to eq(false)
    end
  end
end
