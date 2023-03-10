Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post "/login", to: "sessions#login"
      post "/signup", to: "sessions#signup"

      resources :orders, only: :create
      resources :todos, only: :index
    end
  end
end
