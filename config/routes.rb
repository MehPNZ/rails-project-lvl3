Rails.application.routes.draw do
  root 'home#index'
  
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    resource :session, only: :destroy
  end
end
