class ItemCategory < ApplicationRecord
  belongs_to :item
  belongs_to :category
  
  scope :sort_order, -> (order) { order(order) }
  
  scope :category_items, -> (category, page) { 
    on_category(category).
    display_list(page)
  }
  
  scope :sort_items, -> (sort_order, page) {
    on_element(sort_order[:sort_element]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }
  
  def self.maltilevel_category_create(item, parent_id, children_id, grandchildren_id)
    if parent_id.present?
      category = Category.find(parent_id)
      ItemCategory.create(item_id: item.id, category_id: category.id)
    end

    if children_id.present?
      category = Category.find(children_id)
      ItemCategory.create(item_id: item.id, category_id: category.id)
    end

    if grandchildren_id.present?
      category = Category.find(grandchildren_id)
      ItemCategory.create(item_id: item.id, category_id: category.id)
    end
  end
  
  def self.category_create(item, parent_id, children_id, grandchildren_id)
    if parent_id.present?
      category = Category.find(parent_id)
      ItemCategory.create(category_id: category.id)
    end

    if children_id.present?
      category = Category.find(children_id)
      ItemCategory.create(category_id: category.id)
    end

    if grandchildren_id.present?
      category = Category.find(grandchildren_id)
      ItemCategory.create(category_id: category.id)
    end
  end
  

end
