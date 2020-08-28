require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 1, '2' => 1}) }

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do

      expect(subject.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      cart = Cart.new({
        '1' => 1,
        '2' => 1
      })

      subject.add_pet(1)
      subject.add_pet(2)

      expect(subject.contents).to eq({'1' => 2, '2' => 2})
    end
  end

  describe "#contains_pet" do
    it "can see if pet exists in cart" do
      expect(subject.contains_pet("1")).to eq(true)
      expect(subject.contains_pet("5")).to eq(false)
    end
  end

  describe "#no_favorites" do
    it 'can see if there are no pets in cart' do
      expect(subject.no_favorites).to eq(false)
      subject.remove_pet("1")
      subject.remove_pet("2")
      expect(subject.no_favorites).to eq(true)
    end
  end

  describe "#remove_all_pets" do
    it 'can remove all pets from cart' do
      expect(subject.remove_all_pets).to eq({})
    end
  end
end
