Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchant_search#index'
      get 'items/find_all', to: 'item_search#index'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end
      resources :items do
        resources :merchant, only: [:index], controller: :item_merchant
      end
    end
  end
end
