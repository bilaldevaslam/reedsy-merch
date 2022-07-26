# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def list_price
        response =
          permitted_params['items'].map do |item|
            product = Product.find_by(code: item[:code])

            if product && item[:quantity].to_i.positive?
              @total_price = (@total_price || 0) + (product.sale_price(quantity: item[:quantity].to_i) * item[:quantity].to_i)
              "#{item[:quantity]} #{item[:code]}"
            else
              "No results found for [#{item[:quantity]} #{item[:code]}]"
            end
          end

        response.push(total: @total_price) if @total_price.positive?
        render_response response
      end

      private

      # setting optional pagination for faster API performance
      def load_collection
        self.current_collection =
          collection_scope.page(params[:page]).order(:id)
      end

      # params that are allowed/required to update/create the resource
      def resource_params
        params.require(:product).permit(
          :price
        )
      end

      # params that are allowed for products#list_price method
      def permitted_params
        params.require(:products).permit(
          items: %i[code quantity]
        )
      end
    end
  end
end
