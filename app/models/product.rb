# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  name       :string           not null
#  price      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  paginates_per 5

  has_many :discounts, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true

  def sale_price(quantity: nil)
    # return the same price unless there are discounts availabile
    discount = discounts.where('quantity_range @> int8range(?)', [quantity, quantity + 1]).first

    return price if discount.nil?

    price - (discount.percentage / 100 * price)
  end
end
