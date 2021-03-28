class Element < ApplicationRecord
  has_many :item_elements # @element.item_elements
  has_many :items, through: :item_elements # @element.items
  
  scope :request_element, -> (element) { find(element.to_i) }
end
