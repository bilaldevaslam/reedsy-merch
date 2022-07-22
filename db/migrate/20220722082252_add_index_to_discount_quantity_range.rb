class AddIndexToDiscountQuantityRange < ActiveRecord::Migration[6.1]
  def change
    add_index :discounts, [:product_id, :quantity_range], unique: true
  end
end
