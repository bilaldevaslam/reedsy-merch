# frozen_string_literal: true

# == Schema Information
#
# Table name: discounts
#
#  id             :bigint           not null, primary key
#  product_id     :bigint           not null
#  quantity_range :int8range        not null
#  percentage     :float            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Discount < ApplicationRecord
  belongs_to :product

  validates :quantity_range, presence: true
  validates :percentage, presence: true, numericality: { only_float: true, greater_than: 0, less_than_or_equal_to: 100, message: 'Discount percentage should be in-between 1-100%' }
  validates :product_id, uniqueness: { scope: :quantity_range, message: 'Discount for specified range already exists!' }
  validates_associated :product
end
