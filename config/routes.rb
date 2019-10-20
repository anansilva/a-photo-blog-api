Rails.application.routes.draw do
  root to: 'api/v1/posts#index'

  post '/auth/login', to: 'authentications#login'

  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create index destroy]
      resources :users, only: %i[create destroy]
    end
  end
end
