class Category < ApplicationRecord
  has_many :items # @category.items
  has_ancestry
  
  scope :request_category, -> (category) { find(category.to_i) }

end
