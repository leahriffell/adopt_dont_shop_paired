class Review < ApplicationRecord 
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
end