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
  include ActiveModel::Serialization

  attr_accessor :quantity, :discount_percentage, :discounted_price

  paginates_per 5

  has_many :discounts, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true

  def sale_price
    # return the same price unless there are discounts availabile
    return price if discount_percentage.nil?

    self.discounted_price = price - (discount_percentage / 100 * price)
  end

  # serializeable hash for product price listing
  def attributes
    {
      code: nil,
      quantity: nil,
      discount_percentage: nil,
      price: nil,
      discounted_price: nil
    }
  end
end
