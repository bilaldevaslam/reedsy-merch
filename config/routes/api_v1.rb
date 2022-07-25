# frozen_string_literal: true

namespace :api do
  namespace :v1, defaults: { format: :json } do
    get :status, to: 'api#status'

    resources :products, only: %i[index]
  end
end
