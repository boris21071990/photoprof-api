Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :photos, only: [:index, :show]
      resources :photographers, only: [:index, :show]
      resources :cities, only: [:index]
      resources :categories, only: [:index]

      post "authentication/login", to: "authentication#login"
      post "authentication/register", to: "authentication#register"
      post "authentication/refresh", to: "authentication#refresh"

      get :user, to: "user#index"

      namespace :photographer do
        get :profile, to: "profile#index"
        patch :profile, to: "profile#update"
        patch "profile/update_image", to: "profile#update_image"

        resources :photos, only: [:index, :create]
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end
