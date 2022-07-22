class Product < ApplicationRecord
  has_many :discounts, dependent: :destroy
end
