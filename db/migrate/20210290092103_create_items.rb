class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer "no"
      t.string "name"
      t.string "image"
      t.integer "rarity"
      t.integer "weight"
      t.integer "max_lvl"
      t.integer "max_atck"
      t.integer "max_hp"
      t.integer "max_spd"
      t.integer "max_critical"
      t.integer "max_bullet"
      t.integer "fire_spd"
      t.integer "num_trajectories"
      t.integer "install_limit"
      t.integer "num_jumps"
      t.integer "closeness"
      t.string "before_evl"
      t.string "after_evl"
      t.integer "kakusei"
      t.boolean "shop"
      t.boolean "gacha"
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
