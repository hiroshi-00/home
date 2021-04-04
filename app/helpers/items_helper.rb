module ItemsHelper
  def rearity_star(rarity)
    return "★★★★★★★" if rarity == 7
    return "★★★★★★☆" if rarity == 6
    return "★★★★★☆☆" if rarity == 5
    return "★★★★☆☆☆" if rarity == 4
    return "★★★☆☆☆☆" if rarity == 3
    return "★★☆☆☆☆☆" if rarity == 2
    return "★☆☆☆☆☆☆" if rarity == 1
  end
  
  def elements_color(element)
    return element.gsub(element, "mu") if element == "無"
    return element.gsub(element, "buturi") if element == "物理"
    return element.gsub(element, "raiden") if element == "雷電"
    return element.gsub(element, "shakunetu") if element == "灼熱"
    return element.gsub(element, "hyousou") if element == "氷霜"
    return element.gsub(element, "dokuso") if element == "毒素"
    return element.gsub(element, "inou") if element == "異能"
  end
  
end
