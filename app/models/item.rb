class Item < ApplicationRecord
  has_many :reviews
  has_many :likes
  
  def reviews_new
    reviews.new
  end
end
