Element.delete_all

elements = ["無", "物理", "雷電", "灼炎", "氷霜", "毒素", "異能"]



elements.each do |i|
  Element.create(name: i)
end