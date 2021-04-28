class Dashboard::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: %i[edit update destroy]
  layout "dashboard/dashboard"
  
  def index
    sort_query = {}
    @sorted = ""
    
    if params[:sort].present?
      slices = params[:sort].split(' ')
      sort_query[slices[0]] = slices[1]
      @sorted = sort_query
    end
    if params[:keyword].present?
      keyword = params[:keyword]
      @total_count = Item.search_for_id_and_name(keyword).count
      @items = Item.search_for_id_and_name(keyword).sort_order(sort_query).display_list(params[:page])
    else
      keyword = ""
      @total_count = Item.count
      @items = Item.sort_order(sort_query).display_list(params[:page])
    end

    @sort_list = Item.sort_list
  end
  
  def new
    @item = Item.new
    @skill = @item.item_skills.build
    @element = @item.item_elements.build
    @category_parent_array = Category.category_parent_array_create
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      logger.debug("============================================================= item #{@item}")
      ItemCategory.maltilevel_category_create(@item, params[:parent_id], params[:children_id], params[:grandchildren_id])
      # skillsテーブル保存
      @skill = Skill.create(skl_name: item_params[:skl_name], skl_detail: item_params[:skl_detail])
      # items_skill保存
      @item_skill = ItemSkill.create(item_id: @item.id, skill_id: @skill.id)
      redirect_to item_path(@item)
    else
      redirect_to dashboard_items_path
    end
  end
  
  def edit
    unless @item.user == current_user
      redirect_to items_path
    end
    @category_parent_array = Category.category_parent_array_create
  end
  
  def update
    if @item.update(item_params)
      item_categories = ItemCategory.where(item_id: @item.id)
      item_categories.destroy_all
      ItemCategory.maltilevel_category_create(
        @item,
        params[:parent_id],
        params[:children_id],
        params[:grandchildren_id]
      )
      redirect_to @item
    else
      @category_parent_array = Category.category_parent_array_create
      render 'edit'
    end
  end
  
  def destroy
    @item.destroy
    redirect_to items_path
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:children_id]).children
  end
  
  private
  
    def set_item
      @item = Item.find(params[:id])
    end
    
    def item_params
      params.require(:item).permit(
                :no, :name , :image, :rarity, :weight, :max_lvl, :max_atck, :max_hp, :max_spd, :max_critical, :max_bullet, :fire_spd, :num_trajectories, 
                :install_limit, :closeness, :num_jumps, :before_evl, :after_evl, :kakusei, :shop, :gacha, :skl_name, :skl_detail,
                category_ids: [], element_ids: [], item_elements_attributes: [:id, :item_id, :element_id], item_category_attributes: [:id, :item_id, :category_id])
    end
    
  
end
