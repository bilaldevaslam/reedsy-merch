# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApiController
      private

      # setting optional pagination for faster API performance
      def load_collection
        self.current_collection =
          Product.page(params[:page])
      end

      def resource_params
        params.require(:product).permit(
          :price
        )
      end
    end
  end
end
