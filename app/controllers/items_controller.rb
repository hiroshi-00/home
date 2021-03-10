class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  PER = 50
  
  
  def index
    @items = Item.all.page(params[:page]).per(PER)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to item_url @item
  end

  def show
    @reviews = @item.reviews_with_id
    @review = @reviews.new
    @star_repeat_select = Review.star_repeat_select
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to item_url @item
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end
  
  private
  
    def set_item
      @item = Item.find(params[:id])
    end
    
    def item_params
      params.require(:item).permit(
                :no, :name , :image, :rarity, :weight, :max_lvl, :max_atck, :max_hp, :max_spd, :max_critical,
                :max_bullet, :fire_spd, :num_trajectories, :install_limit, :closeness, :skl_one, :skl_one_element, :skl_one_detail,
                :skl_two, :skl_two_element, :skl_two_detail, :skl_three, :skl_three_detail, :before_evl, :after_evl, :kakusei, :shop, :gacha,
                :user_id)
    end

end
