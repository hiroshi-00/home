class Dashboard::CategoriesController < ApplicationController
  before_action :authenticate_admin!, except: :index
  before_action :set_category, only: %i[show edit update destroy]
  layout "dashboard/dashboard"

  def index
    @categories = Category.display_list(params[:page])
    @category_parent_array = Category.category_parent_array_create
  end
  
  def main_categories
    @categories = Category.display_list(params[:page])
    @category_parent_array = Category.category_parent_array_create
  end
  
  def grandchildren_categories
    @categories = Category.display_list(params[:page])
    @category_parent_array = Category.category_parent_array_create
  end

  def show
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      ItemCategory.category_create(@item, params[:parent_id], params[:children_id], params[:grandchildren_id])
    else
      @category_parent_array = Category.category_parent_array_create
      render 'index'
    end
    redirect_to dashboard_categories_path
    
  end

  def edit
  end

  def update
    @category.update(category_params)
    @category.save
    redirect_to dashboard_categories_path
  end

  def destroy
    @category.destroy
    redirect_to dashboard_categories_path
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.permit(:name, :ancestry, :item_id)
    end
end