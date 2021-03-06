Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations',
          sessions: 'api/v1/auth/sessions',
          passwords: 'api/v1/auth/passwords'
      }
    end
    resources :users
    namespace :v1 do
      get '/infos', to: 'infos#index'
      resources :customers
      resources :posts
      resources :public
    end
  end
end
