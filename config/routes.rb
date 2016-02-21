Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}  

  authenticated :user do
    root 'endpoints#index', as: :authenticated_root
  end
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :endpoints, only: [:index, :create, :edit, :update]
  resources :contacts

  match ':uuid', to: 'endpoints#execute', via: [:post]
end
