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

    @shelter_3 = Shelter.create!(
                                  name: "Save the Giants",
                                  address: "PO Box 664",
                                  city: "Broomfield",
                                  state: "CO",
                                  zip: "80038"
                                  )

    @shelter_4 = Shelter.create!(
                                  name: "Cat Care Society",
                                  address: "5787 W 6th Ave",
                                  city: "Lakewood",
                                  state: "CO",
                                  zip: "80214"
                                  )

    @pet_1 = Pet.create!(
                        image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                        name: "Fluffy",
                        approximate_age: "15 weeks",
                        sex: "Female",
                        shelter_id: @shelter.id,
                        description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                        adoption_status: "adoptable"
                      )

    @pet_2 = Pet.create!(
                          image: "https://i.pinimg.com/564x/2e/94/aa/2e94aaff89dcf73b17de85b17cddc038.jpg",
                          name: "Bernard",
                          approximate_age: "1",
                          description: "I like to spit!",
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

    @review_3 = @shelter_2.reviews.create!(
      title: "Love my new friend!",
      rating: 5,
      content: "They take such good care of their doggies."
    )

    @review_4 = @shelter_3.reviews.create!(
      title: "Stinky",
      rating: 1,
      content: "The facility smelled so bad."
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
    it "can get top 3 highest reviewed shelters" do
      expect(Shelter.top_three).to eq([@shelter_2, @shelter, @shelter_3])
    end
  end

  describe "instance methods" do
    it "can see if a shelter has any reviews" do
      expect(@shelter.has_reviews).to eq(true)
      expect(@shelter_4.has_reviews).to eq(false)
    end

    it "can get average review rating for a shelter" do
      expect(@shelter.avg_rating).to eq(3.5)
      expect(@shelter_4.avg_rating).to eq("No reviews yet")
    end

    it "can see if a shelter has any pending applications" do
      expect(@shelter.has_pending_apps).to eq(false)
      expect(@shelter_2.has_pending_apps).to eq(true)
    end

    it "can delete all associations of a shelter" do
      cart = Cart.new({"#{@pet_1.id}" => 1, "#{@pet_2.id}" => 1})
      @shelter.delete_shelter_and_associations(@shelter.id, cart)
      expect(Pet.where(id: @pet_1.id)).to eq([])
      expect(Review.where(id: @review_1.id)).to eq([])
      expect(Review.where(id: @review_2.id)).to eq([])
      expect(Shelter.where(id: @shelter.id)).to eq([])
    end
  end
end
