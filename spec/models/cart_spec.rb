require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 1, '2' => 1}) }

  describe "#total_count" do
    it "can calculate the total number of pets it holds" do
      cart = Cart.new({
        '1' => 1,
        '2' => 1
      })
      expect(cart.total_count).to eq(2)
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
end
