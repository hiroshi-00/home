Category.delete_all

parent = Category.create(name: "武器")
parent_children_array = ["拳銃", "自動ライフル", "拡散銃", "狙撃銃", "ロケット砲", "近接", "スプレー", "特殊", "投擲", "設置"]
    
parent_grandchildren_array = [
  ["拳銃・単発", "拳銃・射速"], # 拳銃の子
  [], # 自動ライフルの子
  ["拡散銃・単発", "拡散銃・多発"], # 拡散銃の子
  [], # 狙撃銃の子
  [], # ロケット砲の子
  ["近接・剣/刀", "近接・鎖鋸"], # 近接の子 
  ["スプレー", "スプレー・起動型", "スプレー・強化型", "スプレー・切替型"], # スプレーの子
  ["特殊", "特殊・弓"], # 特殊の子
  [], # 投擲の子
  ["設置・人形", "設置・誘導人形", "設置・砲台", "設置・地雷", "設置・古代兵器", "設置・特殊"] # 設置の子
]

parent_children_array.each_with_index do |children, index|
  children = parent.children.create(name: children)
  parent_grandchildren_array[index].each do |grandchildren|
    children.children.create(name: grandchildren)
  end
end

parent = Category.create(name: "服装")
parent = Category.create(name: "勲章")
parent = Category.create(name: "従魔")
parent_children_array = ["従魔", "従魔の欠片"]
parent_children_array.each_with_index do |children|
  children = parent.children.create(name: children)
end

parent = Category.create(name: "素材")
