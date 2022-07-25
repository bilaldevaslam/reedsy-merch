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

  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
end
