class GachasController < ApplicationController
  Pickup_Gacha_Num = 6
  def index
    @gachas = Item.gacha_list(Pickup_Gacha_Num)
    
    @shops = Item.where(shop: true).all
    
    @categories = Category.all
    @elements = Element.all
  end
  
  def shop
  end
end
