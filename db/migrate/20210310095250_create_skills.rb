class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string "skl_name"
      t.text "skl_detail"

      t.timestamps
    end
  end
end
