Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      resources :merchants, only: [:index, :show]
      #  namespace :merchants do 
      #         resources :items, only: [:index]
      #       end
    get "/merchants/:merchant_id/items", to: 'merchant_items#index'
      # resources :merchant_items, only: [:index], controller: :merchant_items
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end


