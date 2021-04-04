class Table < ActiveRecord::Migration[5.2]
  def change
    remove_column :elements, :item_element, :string
    remove_column :elements, :skl_element, :string
    add_column :elements, :name, :string
  end
end
