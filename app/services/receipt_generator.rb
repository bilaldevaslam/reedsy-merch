# frozen_string_literal: true

class ReceiptGenerator
  attr_accessor :items, :discounts, :params, :product

  def initialize(items: nil, params: nil)
    @items = items
    @params = params
  end

  def generate
    @params.each_with_object({ items: [], total_price: 0 }) do |param, result|
      # skipping product codes passed in params that does not exists in the database
      next unless valid_product_code?(code: param[:code]) && param[:quantity].to_i.positive?

      @product.quantity = param[:quantity].to_i
      @product.discount_percentage = product_discount
      result[:total_price] += @product.sale_price * @product.quantity
      result[:items].push(@product.serialized_hash)
    end
  end

  private

  # maps the current product from the list of products if the product is valid and exists
  def valid_product_code?(code: nil)
    @product = @items.find { |prod| prod.code == code }
  end

  # from available loaded discounts, finding the applicable discount percentage for the current processed product
  def product_discount
    @product.discounts.group_by(&:product_id)[@product.id]&.find do |discount|
      return discount.percentage if discount.quantity_range.include?(@product.quantity)
    end
  end
end
