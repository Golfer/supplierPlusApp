Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'attachments#index'

  devise_for :users
  resources :invoices, only: %i[index show destroy]
  resources :attachments do
    member do
      get :file_download
      get :file_processed_download
    end
  end
  resources :users, only: %i[index show destroy]
  resources :dashboard, only: :index
end
