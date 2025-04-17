
Rails.application.routes.draw do
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
  
  root 'dashboard#index'
end