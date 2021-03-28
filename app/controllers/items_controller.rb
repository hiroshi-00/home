class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  before_action :sort_params_exist?, only: %i[index]
  
  PER = 15
  
  def index
    logger.debug("----item index ")
    logger.debug("======================== search = #{params[:search]}")
    # logger.debug("============================ sort_params category sort #{params[:category]}")
    if params[:category].present?
      @category = Category.request_category(params[:category])
      # logger.debug("============================ Category #{@items = Item.where(category_id: params[:category])}")
      # @items = Item.category_items(@category, params[:page])
      @items = Item.where(category_id: params[:category])
      
    elsif params[:element].present?
      # logger.debug("============================ sort_params element sort in #{params[:element]}")
      @element = Element.request_element(params[:element])
      # @items = ItemElement.element_items(@element, params[:page])
      # logger.debug("============================ ItemElement.where(element_id: 1).pluck(:item_id) #{@items = Item.where(id: ItemElement.where(element_id: params[:element]).pluck(:item_id))}")
      @items = Item.where(id: ItemElement.where(element_id: params[:element]).pluck(:item_id))
      
    elsif params[:keyword].present?
      keyword = params[:keyword]
      @total_count = Item.search_item(item, keyword).count
      @items = Item.search_item(item, keyword).display_list(params[:page])
      
    elsif params[:keyword] == ""
      @total_count = Item.count
      @items = Item.display_list(params[:page])
      
    else
      @items = Item.display_list(params[:page])
    end
      
    @categories = Category.all
    @elements = Element.all
    @sort_list = Item.sort_list
  end

  def new
    @item = Item.new
    @skill = @item.item_skills.build
    @element = @item.item_elements.build
  end

  def create
    logger.debug("========================== skl_name = #{item_params[:skl_name]}")
    logger.debug("========================== skl_detail = #{item_params[:skl_detail]}")
    
    
    @item = Item.new(item_params)
    if @item.save
      # skillsテーブル保存
      @skill = Skill.create(skl_name: item_params[:skl_name], skl_detail: item_params[:skl_detail])
      # items_skill保存
      @item_skill = ItemSkill.create(item_id: @item.id, skill_id: @skill.id)
      redirect_to item_path(@item)
    else
      render :new
    end
    
  end

  def show
    @elements = @item.item_elements
    @reviews = @item.reviews
    @review = @reviews.new
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
                :no, :name , :image, :rarity, :weight, :max_lvl, :max_atck, :max_hp, :max_spd, :max_critical, :max_bullet, 
                :fire_spd, :num_trajectories, :install_limit, :closeness, :num_jumps, :before_evl, :after_evl, :kakusei, :shop, :gacha, :category_id, :skl_name, :skl_detail,
                item_elements_attributes: [:id, :item_id, :element_id])
    end
    
    def sort_params_exist?
       if params[:category].nil?
         params[:category] = ""
       end
       
       if params[:element].nil?
         params[:elements] = ""
       end
      
    end
    
end
