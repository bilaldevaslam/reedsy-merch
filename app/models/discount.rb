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
end
