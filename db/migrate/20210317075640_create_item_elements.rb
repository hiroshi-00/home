class CreateItemElements < ActiveRecord::Migration[5.2]
  def change
    create_table :item_elements do |t|
      t.references :item, foreign_key: true
      t.references :element, foreign_key: true

      t.timestamps
    end
  end
end
