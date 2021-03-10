module ItemsHelper
  def rarity_on_star(rarity)
    return "★★★★★★★" if rarity == 7
    return "★★★★★★☆" if rarity == 6
    return "★★★★★☆☆" if rarity == 5
    return "★★★★☆☆☆" if rarity == 4
    return "★★★☆☆☆☆" if rarity == 3
    return "★★☆☆☆☆☆" if rarity == 2
    return "★☆☆☆☆☆☆" if rarity == 1
  end
  
  
end
