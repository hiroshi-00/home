class CreateItemSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :item_skills do |t|
      t.references :item, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
