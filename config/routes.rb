Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Custom password reset routes
  scope :users do
    get 'password/reset', to: 'users/passwords#new', as: :new_user_password
    post 'password/validate', to: 'users/passwords#validate', as: :validate_user_password
    get 'password/security', to: 'users/passwords#security', as: :security_user_password
    post 'password/verify', to: 'users/passwords#verify', as: :verify_user_password
    get 'password/change', to: 'users/passwords#change', as: :change_user_password
    patch 'password/update', to: 'users/passwords#update', as: :update_user_password
  end

  # Root route
  root to: 'dashboard#index'
  
  # Dashboard routes
  get 'dashboard', to: 'dashboard#index'

  # Admin namespace
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :clients do
      resources :projects
    end
    resources :users
  end

  # Client namespace
  namespace :client do
    get 'dashboard', to: 'dashboard#index'
    resources :projects do
      resources :requirements
      resources :attachments, only: [:create, :destroy]
    end
  end

  # Public routes
  resources :clients do
    resources :projects, shallow: true do
      member do
        patch :change_status
      end
      resources :requirements
      resources :attachments, only: [:create, :destroy]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  # Client-facing public form
  get 'projects/:id/public', to: 'projects#public_show', as: :public_project
  patch 'projects/:id/public', to: 'projects#public_update'
  
  # Public project routes
  resources :projects, only: [:show] do
    member do
      get 'public_update'
      patch 'public_update', to: 'projects#update_public'
    end
  end
end