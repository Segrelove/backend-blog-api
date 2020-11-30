Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :articles
      resources :categories
    end
  end

  root to: "home#index"

  ## Authentication Logic
  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy

end
