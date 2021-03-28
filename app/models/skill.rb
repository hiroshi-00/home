class Skill < ApplicationRecord
  has_many :item_skills
  has_many :items, through: :item_skills
  
end
