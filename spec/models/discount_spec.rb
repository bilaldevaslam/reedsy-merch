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
require 'rails_helper'

RSpec.describe Discount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
