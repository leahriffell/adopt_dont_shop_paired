class Review < ApplicationRecord 
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content

  def has_image 
    optional_picture != nil
  end
end