# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    products { nil }
    quantity_range { "" }
    percentage { 1.5 }
  end

  factory :product do
    code { "MyString" }
    name { "MyString" }
    price { 1.5 }
  end

end
