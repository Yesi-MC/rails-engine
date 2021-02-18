Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      resources :merchants, only: [:index, :show]
      get "/merchants/:merchant_id/items", to: 'merchant_items#index'
      resources :items, only: [:index, :show, :create, :update, :destroy]
      get "/items/:item_id/merchant", to: 'item_merchant#index'
    end
  end
end


