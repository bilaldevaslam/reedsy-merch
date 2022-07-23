# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.int8range :quantity_range, null: false
      t.float :percentage, null: false

      t.timestamps
    end
  end
end
