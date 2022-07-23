# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :discounts, dependent: :destroy
end
