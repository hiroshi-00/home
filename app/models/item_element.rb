class ItemElement < ApplicationRecord
  belongs_to :item
  belongs_to :element
  extend DisplayList
  
  scope :sort_order, -> (order) { order(order) }
  
  scope :element_items, -> (element, page) { 
    on_element(element).
    display_list(page)
  }
  
  scope :sort_items, -> (sort_order, page) {
    on_element(sort_order[:sort_element]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }
end
