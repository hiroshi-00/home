class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user
  
  def save_review(review, review_params)
    review.content = review_params[:content]
    review.user_id = review_params[:user_id]
    review.item_id = review_params[:item_id]
    save
  end
end
