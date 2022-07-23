# frozen_string_literal: true

# setting up products along with their discounts
products = [
  {
    code: 'MUG',
    name: 'Reedsy Mug',
    price: 6.0
  },
  {
    code: 'TSHIRT',
    name: 'Reedsy T-shirt',
    price: 15.0
  },
  {
    code: 'HOODIE',
    name: 'Reedsy Hoodie',
    price: 20.00
  }
]

min_quant = 10
max_quant = 19

products.each do |p|
  product = Product.create!(p)

  product.discounts.create!(quantity_range: 3..Float::INFINITY, percentage: 30) if product.code == 'TSHIRT'

  next unless product.code == 'MUG'

  (2..28).step(2).each do |discount|
    product.discounts.create!(quantity_range: min_quant..max_quant, percentage: discount)
    min_quant += 10
    max_quant += 10
  end

  product.discounts.create!(quantity_range: 150..Float::INFINITY, percentage: 30)
end
