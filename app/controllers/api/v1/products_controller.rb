# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      private

      # Question 1: Implement an API endpoint that allows listing the existing items in the store, as well as their attributes.
      # setting optional pagination for faster API performance
      def load_collection
        self.current_collection =
          Product.page(params[:page])
      end

      def resource_params
        params.require(:product).permit(
          :code, :name, :price
        )
      end
    end
  end
end
