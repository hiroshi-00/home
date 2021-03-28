Category.delete_all
weapon_child_array = [
    "拳銃", "自動ライフル", "拡散銃", "狙撃銃", "ロケット砲", 
    "近接", "スプレー", "特殊", "投擲", "設置"]

weapon_grandchild_array = [
    ["単発", "射速"], [], ["単発", "多発"], [], [],
    ["鎖鋸", "剣/刀"], ["スプレー", "起動型", "強化型", "切替型"],  ["特殊", "弓"],
    [], ["人形", "誘導人形", "砲台", "地雷", "古代兵器", "特殊" ]]

parent = Category.create(name: "武器")
weapon_child_array.each_with_index do |child, i|
  
  child = parent.children.create(name: child)
  
  weapon_grandchild_array[i].each do |grandchild|
    child.children.create(name: grandchild)
  end
end

parent = Category.create(name: "服装")
parent = Category.create(name: "勲章")

# 4
# 10


# 武器-拳銃-単発
# 武器-拳銃-秒速

# 武器
#   拳銃
#     単発
#     射速
#   自動ライフル


parent = Category.create(name: "素材")

