class Item < ApplicationRecord
  
  attr_accessor :skl_name
  attr_accessor :skl_detail
  
  
  belongs_to :category # @item.category
  has_many :reviews # @item.reviews
  has_many :likes # @item.likes
  has_many :item_skills # @item.item_skills
  has_many :skills, through: :item_skills # @item.skills
  has_many :item_elements # @item.item_elements
  has_many :elements, through: :item_elements
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
  scope :search_item, -> (keyword) { where("name LIKE ?", "%#{keyword}%")}

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
  
  
  

#   scope :search_item, -> (search_params) do      #scopeでsearchメソッドを定義。(search_params)は引数
#     return if search_params.blank?      #検索フォームに値がなければ以下の手順は行わない

#     name_kana_like(search_params[:name_kana])
#       .check_in_from(search_params[:check_in_from])
#       .check_in_to(search_params[:check_in_to])
#       .phone_like(search_params[:phone])   #下記で定義しているscopeメソッドの呼び出し。「.」で繋げている
#   end

#   scope :item_name_like, -> (item_name) { where("name LIKE ?", "%#{item}%")}
#   scope :skl_name_like, -> (skl_name) { where("name LIKE ?", "%#{item}%")}

#   scope :name_kana_like, -> (name_kana) { where('name_kana LIKE ?', "%#{name_kana}%") if name_kana.present? }  #scopeを定義。
#   scope :check_in_from, -> (from) { where('? <= check_in', from) if from.present? }
#   scope :check_in_to, -> (to) { where('check_in <= ?', to) if to.present? }
#   #日付の範囲検索をするため、fromとtoをつけている
#   scope :phone_like, -> (phone) { where('phone LIKE ?', "%#{phone}%") if phone.present? }
# 　scope :メソッド名 -> (引数) { SQL文 }
# 　if 引数.present?をつけることで、検索フォームに値がない場合は実行されない

  
end
