# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def list_price
        total_price = 0
        items = permitted_params['items']

        response =
          items.map do |item|
            product = Product.find_by(code: item[:code])

            next unless product && item[:quantity].positive?

            unit_price = product.sale_price(quantity: item[:quantity])
            total_price += unit_price * item[:quantity]
            "#{item[:quantity]} #{item[:code]}"
          end

        response << "Total: #{total_price}" if total_price.positive?
        render_response response
      end

      private

      # setting optional pagination for faster API performance
      def load_collection
        self.current_collection =
          collection_scope.page(params[:page]).order(:id)
      end

      def resource_params
        params.require(:product).permit(
          :price
        )
      end

      def permitted_params
        params.require(:products).permit(
          items: %i[code quantity]
        )
      end
    end
  end
end
