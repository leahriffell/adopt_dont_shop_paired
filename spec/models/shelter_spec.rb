require 'rails_helper'

describe Shelter, type: :model do
  before :each do
    @shelter = Shelter.create!(
                                name: "Rocky Mountain Puppy Rescue",
                                address: "10021 E Iliff Ave",
                                city: "Aurora",
                                state: "CO",
                                zip: "80247"
                              )
    @shelter_2 = Shelter.create!(
                                name: "Espiritu Alpacas",
                                address: "8221 S Blue Creek Rd",
                                city: "Evergreen",
                                state: "CO",
                                zip: "80439"
                                )
    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          sex: "Male",
                          shelter_id: @shelter_2.id,
                          adoption_status: "Pending",
                          approved_applicant: "Paul Bunyan"
                        )

    @review_1 = @shelter.reviews.create!(
                                title: "Mountains of Love! <3",
                                rating: 5,
                                content: "Super clean, well-facilitated, and healthy pups.",
                                optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg"
                              )

    @review_2 = @shelter.reviews.create!(
                                title: "meh",
                                rating: 2,
                                content: "it was weird."
                              )
    @application = @pet_2.applications.create!(
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
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "class methods" do

    it "can get average review rating for a shelter" do
      expect(@shelter.avg_rating).to eq(3.5)
    end
  end

  describe "instance methods" do
    it "can see if a shelter has any pending applications" do
      expect(@shelter.has_pending_apps).to eq(false)
      expect(@shelter_2.has_pending_apps).to eq(true)
    end
  end
end
