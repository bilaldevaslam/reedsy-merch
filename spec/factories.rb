# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { 'MyString' }
    name { 'MyString' }
    price { 1.5 }
  end

  factory :discount do
    product { Product.first }
    quantity_range { 3..Float::INFINITY }
    percentage { 30 }
  end
end
