class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.string :item_element
      t.string :skl_element

      t.timestamps
    end
  end
end
