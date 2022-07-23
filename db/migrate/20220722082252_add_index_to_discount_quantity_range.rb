# frozen_string_literal: true

class AddIndexToDiscountQuantityRange < ActiveRecord::Migration[6.1]
  def change
    add_index :discounts, %i[product_id quantity_range], unique: true
  end
end
