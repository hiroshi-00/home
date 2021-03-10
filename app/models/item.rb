class Item < ApplicationRecord
  has_many :reviews
  has_many :likes
  
  def reviews_new
    reviews.new
  end
  
  def reviews_with_id
    reviews.reviews_with_id
  end

  
end
