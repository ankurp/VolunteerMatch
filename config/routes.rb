require 'sidekiq/web'

Rails.application.routes.draw do
  resources :bookmarks
  resources :comments
  resources :posts
  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services    

    root to: "users#index"
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :locations, only: [:show, :new, :edit, :update]
  resources :organizations, only: [:show, :new, :edit, :update]
  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { registrations: "registrations", omniauth_callbacks: "users/omniauth_callbacks" }
  resources :users, only: [:show, :edit, :update]

  constraints ApplicationHelper::SignedIn.new do
    root to: "dashboards#show"
  end

  root to: 'home#index', as: :logged_out_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
