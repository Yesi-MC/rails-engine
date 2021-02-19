Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      get "/merchants/find", to: "merchants#find"
      resources :merchants, only: [:index, :show]
      get "/merchants/:merchant_id/items", to: 'merchant_items#index'

      get "/items/find_all", to: "items#find_all"
      resources :items, only: [:index, :show, :create, :update, :destroy]
      get "/items/:item_id/merchant", to: 'item_merchant#index'

      get "/revenue/merchants", to: "revenue_merchant#index"
    end
  end
end


