require 'rails_helper'

describe Review, type: :model do
  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'instance methods' do 
    before :each do 
      @shelter_1 = Shelter.create!(
                                    name: "Rocky Mountain Puppy Rescue",
                                    address: "10021 E Iliff Ave",
                                    city: "Aurora",
                                    state: "CO",
                                    zip: "80247"
                                  )

      @review_1 = @shelter_1.reviews.create!(
                                            title: "Mountains of Love! <3",
                                            rating: 5,
                                            content: "Super clean, well-facilitated, and healthy pups.", 
                                            optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg"
                                          )

      @review_2 = @shelter_1.reviews.create!(
                                            title: "meh",
                                            rating: 2,
                                            content: "it was weird."
                                          )
    end

    it 'can determine if review has an image or not' do
      expect(@review_1.has_image).to eq(true)
      expect(@review_2.has_image).to eq(false)
    end
  end
end