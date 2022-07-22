# frozen_string_literal: true

module Api
  module V1
    module Concerns
      module Respondable
        extend ActiveSupport::Concern

        def index
          render_response load_collection
        end

        def show
          render_response get_resource
        end

        def new
          render_response build_resource
        end

        def edit
          get_resource
          render_response get_resource
        end

        def create
          render_response current_resource if create_resource
        end

        def update
          get_resource.assign_attributes(resource_params)
          render_response current_resource if update_resource
        end

        def destroy
          get_resource
          destroy_resource
          head http_success
        end

        protected

        def render_response(response)
          render json: response, status: http_success
        end

        def http_success
          return :created if action_name.to_sym == :create
          return :no_content if action_name.to_sym == :destroy

          :ok
        end

        def resource_klass
          controller_name.classify.safe_constantize
        end

        def resource_instance_name
          controller_name.singularize
        end

        def collection_instance_name
          controller_name
        end

        def resource_scope
          resource_klass
        end

        def collection_scope
          resource_scope
        end

        def resource_params
          raise I18n.t('api.errors.override_params')
        end

        def build_resource
          self.current_resource ||= resource_klass.new(resource_params)
        end

        def get_resource
          self.current_resource ||= resource_scope.find(params[:id]) if params[:id]
        end

        def create_resource
          build_resource.save!
        end

        def update_resource
          current_resource.save!
        end

        def destroy_resource
          current_resource.destroy
        end

        def current_resource=(resource)
          instance_variable_set(:"@#{resource_instance_name}", resource)
        end

        def current_resource
          instance_variable_get(:"@#{resource_instance_name}")
        end

        def current_collection=(collection)
          instance_variable_set(:"@#{collection_instance_name}", collection)
        end

        def current_collection
          instance_variable_get(:"@#{collection_instance_name}")
        end

        def load_collection
          self.current_collection = collection_scope.all
        end
      end
    end
  end
end
