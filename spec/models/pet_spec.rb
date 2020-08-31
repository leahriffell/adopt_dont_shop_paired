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
                          adoption_status: "Pending",
                          approved_applicant: "Paul Bunyan"
                        )

    @pet_2 = @shelter_1.pets.create!(
                          image: "https://qph.fs.quoracdn.net/main-qimg-775e3ef3258895374fcd610163d8c8e3",
                          name: "Turquoise",
                          approximate_age: "1 year",
                          sex: "Male",
                          description: "I am looking for green pastures to roam and play in.",
                          adoption_status: "Adoptable",
                          approved_applicant: nil
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

    it "can change application status to pending" do
      @pet_2.change_to_pending
      expect(@pet_2.adoption_status).to eq("Pending")
    end

    it "can see if pet has pending adoption status" do
      expect(@pet_1.is_pending).to eq(true)
      expect(@pet_2.is_pending).to eq(false)
    end 

    it "can can check if it has an approved applicant" do
      expect(@pet_1.has_approved_applicant).to eq(true)
      expect(@pet_2.has_approved_applicant).to eq(false)
    end

    it "can change application status to adoptable" do
      @pet_1.change_to_adoptable
      expect(@pet_1.adoption_status).to eq("Adoptable")
    end
  end
end
