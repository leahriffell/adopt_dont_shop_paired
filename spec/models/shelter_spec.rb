require 'rails_helper'

describe Shelter, type: :model do
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
    before :each do 
      @shelter = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
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

    end

    it "can get average review rating for a shelter" do
      expect(@shelter.avg_rating).to eq(3.5)
    end
  end
end