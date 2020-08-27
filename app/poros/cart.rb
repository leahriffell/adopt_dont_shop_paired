class Cart
  attr_reader :contents

  def initialize(contents)
    if contents
      @contents = contents
    else
      @contents = Hash.new
    end
  end

  def total_count
    @contents.values.sum
  end

  # def add_pet(pet_id)
  #   @contents[pet_id.to_s] += 1
  # end

  def add_pet(pet_id)
    pet_id_str = pet_id.to_s
    @contents[pet_id_str] ||= 0
    @contents[pet_id_str] += 1
  end

  # def find
  #
  # end
end
