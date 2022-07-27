# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      def list_price
        products = Product.where(code: item_codes)
        discounts_by_product = Discount.where(product: products).group_by(&:product_id)

        response =
          permitted_params['items'].each_with_object({ items: [], total_price: 0 }) do |item, result|

            next unless products.any? { |prod| prod.code == item[:code] } && item[:quantity].to_i.positive?

            product = products.find { |prod| prod.code == item[:code] }
            product.quantity = item[:quantity].to_i
            product.discount_percentage = discounts_by_product[product.id]&.find { |disc| disc.quantity_range.include?(product.quantity) }&.percentage
            result[:total_price] += product.sale_price * product.quantity
            result[:items].push(product.serializable_hash)
          end

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

      def item_codes
        params[:products][:items].pluck(:code)
      end

      def quantities
        params[:products][:items].pluck(:quantity)
      end
    end
  end
end
