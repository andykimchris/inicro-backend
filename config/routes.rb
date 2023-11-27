# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  require 'sidekiq/web'
  Rails.application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Defines the root path route ("/")
  # root "posts#index"
  devise_for :users,
             path_names: { registration: 'signup', sign_in: 'login', sign_out: 'logout' },
             controllers: { registrations: 'users/registrations', sessions: 'users/sessions',
                            confirmation: 'users/confirmations' }

  namespace :api do
    namespace :v1 do
      resources :listing, only: %i[create show update]
    end
  end
end
