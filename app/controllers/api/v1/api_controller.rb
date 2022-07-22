# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include Concerns::Respondable
      include Concerns::ErrorHandler

      def status
        render json: { online: true }
      end
    end
  end
end
