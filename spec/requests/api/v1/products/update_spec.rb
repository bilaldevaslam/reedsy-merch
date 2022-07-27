# frozen_string_literal: true

# test cases for Question 2
# Implement an API endpoint that allows updating the price of a given product.

describe 'PUT /api/v1/products/:id', type: :request do
  let(:product) { Product.create(code: 'MUG', name: 'xyz', price: 6) }
  let(:api_v1_product_price) { "/api/v1/products/#{product.id}" }

  # testing with valid product price
  context 'when valid price and id is passed in params' do
    let(:params) { { product: { price: 10 } } }

    it 'returns success' do
      put api_v1_product_price, params: params
      expect(response).to have_http_status(:success)
    end

    it 'updates the price of the product' do
      put api_v1_product_price, params: params
      expect(product.reload.price).to eq(params[:product][:price])
    end

    it 'returns the updated product' do
      put api_v1_product_price, params: params
      expect(JSON.parse(response.body)['price']).to eq product.reload.price
    end
  end

  # testing with invalid product price
  context 'when invalid price is passed in a product' do
    let(:params) { { product: { price: 'cake' } } }

    it 'does not return success' do
      put api_v1_product_price, params: params
      expect(response).not_to have_http_status(:success)
    end

    it 'does not update the price value' do
      put api_v1_product_price, params: params
      expect(product.reload.price).not_to eq(params[:product][:price])
    end

    it 'returns the error' do
      put api_v1_product_price, params: params
      expect(JSON.parse(response.body)['errors']['price']).to include('is not a number')
    end
  end

  # testing edge-case for concurrent price update
  context 'when price of product is updated concurrently' do
    it 'raises stale object error' do
      Product.create(code: 'MUG', name: 'xyz', price: 6)
      p1 = Product.first
      p2 = Product.first

      p1.update!(price: 12)
      expect { p2.update!(price: 13) }.to raise_error(ActiveRecord::StaleObjectError)
    end
  end

  # no params passed
  context 'with missing params' do
    it 'returns the missing params error' do
      put api_v1_product_price, params: {}
      expect(JSON.parse(response.body)['error']).to eq 'A required param is missing'
    end
  end
end
