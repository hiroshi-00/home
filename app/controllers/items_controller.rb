class ItemsController < ApplicationController
  before_action :search
  before_action :sort_params_exist?, only: :index
  
  def index
    if params[:category_ids].present? && params[:category_ids] != [""]
      params[:category_ids].delete_at(0)
      # @category = Category.request_category(params[:category])
      # @category = Category.where(id: params[:category_ids])
      # @items = Item.category_items(@category, params[:page])
      @items = Item.where(category_id: params[:category_ids])
    elsif params[:element_ids].present?
      params[:element_ids].delete_at(0)
      item_elements_search(params[:element_ids])
      # @element = Element.request_element(params[:element])
      # @items = ItemElement.element_items(@element, params[:page])
      # @items = Item.where(id: ItemElement.where(element_id: params[:element]).pluck(:item_id))
    elsif params[:category].present?
      @category = Category.request_category(params[:category])
      # logger.debug("============================ Category #{@items = Item.where(category_id: params[:category])}")
      # @items = Item.category_items(@category, params[:page])
      @items = Item.where(id: ItemCategory.where(category_id: params[:category]).pluck(:item_id))
    elsif params[:element].present?
      # logger.debug("============================ sort_params element sort in #{params[:element]}")
      @element = Element.request_element(params[:element])
      # @items = ItemElement.element_items(@element, params[:page])
      # logger.debug("============================ ItemElement.where(element_id: 1).pluck(:item_id) #{@items = Item.where(id: ItemElement.where(element_id: params[:element]).pluck(:item_id))}")
      @items = Item.where(id: ItemElement.where(element_id: params[:element]).pluck(:item_id))
    else
      @items = Item.display_list(params[:page])
    end
    @categories = Category.all
    @elements = Element.all
    @sort_list = Item.sort_list
  end


  def show
    @item = Item.find(params[:id])
    @item_element = @item.item_elements
    @skills = @item.item_skills
    @reviews = @item.reviews_with_id
    @review = @reviews.new
    @star_repeat_select = Review.star_repeat_select
  end

  
  def search 
    @items = Item.search_by_keywords(params[:category_id])
  end
  
  def category_window
    @children = Category.find(params[:parent_id]).children
  end
  
  def category_window
    @elements = Element.find(params[:element_id])
  end

  private
    
    def item_params
      params.require(:item).permit(
                :no, :name , :image, :rarity, :weight, :max_lvl, :max_atck, :max_hp, :max_spd, :max_critical, :max_bullet, :fire_spd, :num_trajectories, 
                :install_limit, :closeness, :num_jumps, :before_evl, :after_evl, :kakusei, :shop, :gacha, :skl_name, :skl_detail,
                category_ids: [], element_ids: [], item_elements_attributes: [:id, :item_id, :element_id], item_category_attributes: [:id, :item_id, :category_id])
    end
    
    def sort_params_exist?
       if params[:category].nil?
         params[:category] = ""
       end
       
       if params[:element].nil?
         params[:elements] = ""
       end
    end
    
    def search
      if params[:keyword].present?
        @keyword = params[:keyword]
        @total_count = Item.search_item(@keyword).count
        @items = Item.search_item(@keyword).display_list(params[:page])
      elsif params[:keyword] == ""
        @total_count = Item.count
        @items = Item.display_list(params[:page])
      else
        @items = Item.display_list(params[:page])
      end
    end
    
    
    def item_elements_search(elements)
      selected_item_elemnt = []
      ItemElement.where(element_id: elements).each do |item_element|
        selected_item_elemnt << item_element.item_id
      end
      @items = Item.where(id: selected_item_elemnt.uniq)
    end
    
end
