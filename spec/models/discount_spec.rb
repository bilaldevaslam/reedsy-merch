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
  before do
    @product = Product.create(code: 'MUG', name: 'xyz', price: 6)
  end

  # Discount association test
  describe Discount do
    context 'when a discount is created' do
      it 'belongs to a product' do
        product = described_class.reflect_on_association(:product)
        expect(product.macro).to eq(:belongs_to)
      end
    end
  end

  # Discount validations test
  describe 'validations' do
    context 'when a discount is created' do
      subject { build :discount }

      it { is_expected.to validate_presence_of(:quantity_range) }
      it { is_expected.to validate_presence_of(:percentage) }
    end
  end

  context 'when factorybot object is created' do
    it 'has a valid factory' do
      discount = create(:discount)
      expect(discount.valid?).to be(true)
    end
  end
end
