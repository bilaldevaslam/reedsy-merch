# frozen_string_literal: true

# test case for question 3 and question 4
# Implement an API endpoint that allows one to check the price of a given list of items.
# We'd like to expand our store to provide some discounted prices in some situations.

describe 'get /api/v1/products/price', type: :request do
  # creating products and discounts
  before do
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

      # variable discounts on mug
      (2..28).step(2).each do |discount|
        product.discounts.create!(quantity_range: min_quant..max_quant, percentage: discount)
        min_quant += 10
        max_quant += 10
      end

      product.discounts.create!(quantity_range: 150..Float::INFINITY, percentage: 30)
    end
  end

  context 'when valid product list is passed' do
    let(:api_v1_products_price) { '/api/v1/products/price' }

    # Items: 1 MUG, 1 TSHIRT, 1 HOODIE
    # Total: 41.00
    it 'returns the calculated price for the given products' do
      params =
        {
          products: {
            items: [
              {
                code: 'MUG',
                quantity: 1
              },
              {
                code: 'TSHIRT',
                quantity: 1
              },
              {
                code: 'HOODIE',
                quantity: 1
              }
            ]
          }
        }
      get api_v1_products_price, params: params
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).last['total']).to eq(41)
    end

    # Items: 9 MUG, 1 TSHIRT
    # Total: 69.00
    it 'returns the calculated price for the given products' do
      params =
        {
          products: {
            items: [
              {
                code: 'MUG',
                quantity: 9
              },
              {
                code: 'TSHIRT',
                quantity: 1
              }
            ]
          }
        }
      get api_v1_products_price, params: params
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).last['total']).to eq(69)
    end

    # Items: 10 MUG, 1 TSHIRT
    # Total: 73.80
    it 'returns the calculated price for the given products' do
      params =
        {
          products: {
            items: [
              {
                code: 'MUG',
                quantity: 10
              },
              {
                code: 'TSHIRT',
                quantity: 1
              }
            ]
          }
        }
      get api_v1_products_price, params: params
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).last['total']).to eq(73.80)
    end

    # Items: 45 MUG, 3 TSHIRT
    # Total: 279.90
    it 'returns the calculated price for the given products' do
      params =
        {
          products: {
            items: [
              {
                code: 'MUG',
                quantity: 45
              },
              {
                code: 'TSHIRT',
                quantity: 3
              }
            ]
          }
        }
      get api_v1_products_price, params: params
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).last['total']).to eq(279.90)
    end

    # Items: 200 MUG, 4 TSHIRT, 1 HOODIE
    # Total: 902.00
    it 'returns the calculated price for the given products' do
      params =
        {
          products: {
            items: [
              {
                code: 'MUG',
                quantity: 200
              },
              {
                code: 'TSHIRT',
                quantity: 4
              },
              {
                code: 'HOODIE',
                quantity: 1
              }
            ]
          }
        }
      get api_v1_products_price, params: params
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).last['total']).to eq(902.0)
    end
  end
end
