# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module ErrorHandler
        extend ActiveSupport::Concern

        included do
          rescue_from ActiveRecord::RecordNotFound,        with: :not_found
          rescue_from ActiveRecord::RecordInvalid,         with: :record_invalid
          rescue_from ActionController::ParameterMissing,  with: :parameter_missing
          rescue_from ActionController::UnpermittedParameters, with: :unpermitted_params
          rescue_from ActiveRecord::StaleObjectError, with: :stale_object
        end

        def not_found(exception)
          logger.info { exception }
          render json: { error: I18n.t('api.errors.not_found', record: resource_instance_name) }, status: :not_found
        end

        def record_invalid(exception)
          logger.info { exception }
          render json: { errors: exception.record.errors.as_json }, status: :unprocessable_entity
        end

        def parameter_missing(exception)
          logger.info { exception }
          render json: { error: I18n.t('api.errors.missing_param') }, status: :unprocessable_entity
        end

        def unpermitted_params(exception)
          logger.info { exception }
          render json: { error: exception }, status: :bad_request
        end

        def stale_object(exception)
          logger.info { exception }
          render json: { error: exception }, status: :conflict
        end
      end
    end
  end
end
