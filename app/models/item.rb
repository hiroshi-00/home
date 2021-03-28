class Item < ApplicationRecord
  
  attr_accessor :skl_name
  attr_accessor :skl_detail
  
  
  belongs_to :category # @item.category
  has_many :reviews # @item.reviews
  has_many :likes # @item.likes
  has_many :item_skills # @item.item_skills
  has_many :skills, through: :item_skills # @item.skills
  has_many :item_elements # @item.item_elements
  has_many :elements, through: :item_elements # @item.elements
  accepts_nested_attributes_for :item_elements, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :item_skills, allow_destroy: true
  
  def reviews_new
    reviews.new
  end
  
  def reviews_with_id
    reviews.reviews_with_id
  end
  
  PER = 15
  
  scope :display_list, -> (page) { page(page).per(PER) }
  
  scope :on_category, -> (category) {where(category_id: category)}
  
  scope :sort_order, -> (order) { order(order) }
  scope :search_item, -> (item, keyword) { where("#{item} LIKE ?", "%#{keyword}%")}

  scope :category_items, -> (category, page) { 
    on_category(category).
    display_list(page)
  }

  scope :sort_items, -> (sort_order, page) {
    on_category(sort_order[:sort_category]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }
  
  scope :sort_items, -> (sort_order, page) {
    on_element(sort_order[:sort_element]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }
  
  scope :sort_list, -> {
    {
      "並び替え" => "", 
      "図鑑番号が低い順" => "no asc",
      "図鑑番号が高い順" => "no desc"
    }
  }

  
end
