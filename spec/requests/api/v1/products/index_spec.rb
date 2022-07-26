# frozen_string_literal: true

# test case for question 1
# Implement an API endpoint that allows listing the existing items in the store, as well as their attributes.
describe 'get /api/v1/products/', type: :request do
  before do
    Product.create(code: 'MUG', name: 'xyz', price: 6)
  end

  context 'when valid request' do
    let(:api_v1_list_products) { '/api/v1/products/?page=1' }

    it 'returns success' do
      get api_v1_list_products
      expect(response).to have_http_status(:success)
    end

    it 'returns the list of products' do
      get api_v1_list_products
      expect(JSON.parse(response.body).length).to be > 0
    end
  end
end
