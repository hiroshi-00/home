class ItemElement < ApplicationRecord
  belongs_to :item
  belongs_to :element
  
  PER = 15
  
  scope :sort_order, -> (order) { order(order) }
  scope :display_list, -> (page) { page(page).per(PER) }
  
  scope :on_element, -> (element) {find_by(element_id: element)}
  
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
