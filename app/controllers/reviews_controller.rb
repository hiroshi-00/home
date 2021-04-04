class ReviewsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    review = item.reviews_new
    review.save_review(review, review_params)
    redirect_to item_url(item)
  end

  private
    def review_params
      params.require(:review).permit(:content, :score).
             merge(user_id: current_user.id, item_id: params[:item_id])
    end
end
