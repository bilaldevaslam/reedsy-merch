# frozen_string_literal: true

namespace :api do
  namespace :v1, defaults: { format: :json } do
    get :status, to: 'api#status'

    resources :products, only: %i[index update] do
      get '/price/', to: 'products#list_price', as: 'list_price', on: :collection
    end
  end
end
