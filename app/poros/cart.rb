class Cart
  attr_reader :contents

  def initialize(contents)
    if contents
      @contents = contents
    else
      Hash.new(0)
    end
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(pet)
    @contents[pet.to_s] += 1
  end

  # def find
  #
  # end
end
