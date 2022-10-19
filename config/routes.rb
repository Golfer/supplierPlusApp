Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'attachments#index'

  devise_for :users
  resources :invoices
  resources :attachments do
    member do
      get :file_download
      get :file_processed_download
    end
  end
  resources :users
  resources :dashboard, only: :index
end
