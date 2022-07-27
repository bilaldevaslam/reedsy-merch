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
require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = described_class.create(code: 'MUG', name: 'xyz', price: 6)
    @discount = @product.discounts.create(quantity_range: 3..Float::INFINITY, percentage: 30)
    @product.discount_percentage = @discount.percentage
  end

  # Product association test
  describe Product do
    context 'with product, there can be multiple discounts' do
      it 'can have one or more discounts' do
        discounts = described_class.reflect_on_association(:discounts)
        expect(discounts.macro).to eq(:has_many)
      end
    end
  end

  # Product validations test
  describe 'validations' do
    context 'when a product is created' do
      subject { build :product }

      it { is_expected.to validate_presence_of(:code) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_uniqueness_of(:code) }
      it { is_expected.to validate_numericality_of(:price) }
    end
  end

  # Product sale price tests
  describe 'check for unit price of product on the basis of quantity' do
    context 'when product does not have any discount' do
      it 'returns the original price of MUG that is 6' do
        @product.discount_percentage = nil
        expect(@product.sale_price).to eq(6)
      end
    end

    context 'when product has discounts avaialble' do
      it 'returns the 30% discounted price for the MUG' do
        expect(@product.sale_price).to eq(4.2)
      end
    end
  end

  context 'when factorybot object is created' do
    it 'has a valid factory' do
      product = create(:product)
      expect(product.valid?).to be(true)
    end
  end
end
