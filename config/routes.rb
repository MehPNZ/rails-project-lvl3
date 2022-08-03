Rails.application.routes.draw do
  scope module: :web do
    namespace :admin do
      resources :categories
      resources :bulletins do
        patch 'archive', on: :member
        patch 'publish', on: :member
        patch 'reject', on: :member
      end
    end

    resources :bulletins do
      patch 'to_moderate', on: :member
      patch 'archive', on: :member
    end

    root 'bulletins#index'

    get '/admin', to: 'admin#index'
    get '/profile', to: 'user#show'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :session, only: :destroy
  end
end
