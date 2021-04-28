class Category < ApplicationRecord
  has_many :item_categories
  has_many :items, through: :item_categories
  has_ancestry
  extend DisplayList
  
  scope :request_category, -> (category) { find(category.to_i) }
  
  
  def self.category_parent_array_create
    category_parent_array = ['---']
    Category.where(ancestry: nil).each do |parent|
      category_parent_array << [parent.name, parent.id]
    end
    return category_parent_array
  end

end
