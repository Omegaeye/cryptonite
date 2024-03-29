Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :coins, only: %i[index] 
      namespace :coins do
        resources :searches, only: %i[create]
      end
    end
  end
end
