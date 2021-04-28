class Table < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :category, foreign_key: true
  end
end
