class RemoveColItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :skl_one, :string
    remove_column :items, :skl_one_element
    remove_column :items, :skl_one_detail
    remove_column :items, :skl_two
    remove_column :items, :skl_two_element
    remove_column :items, :skl_two_detail
    remove_column :items, :skl_three
    remove_column :items, :skl_three_detail
  end
end


