# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def list_price
        items = Product.where(code: item_codes)
        discounts = Discount.where(product: items).group_by(&:product_id)

        receipt = ReceiptGenerator.new(items: items, discounts: discounts, params: permitted_params['items']).generate

        render_response receipt
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

      def item_codes
        params[:products][:items].pluck(:code)
      end
    end
  end
end
