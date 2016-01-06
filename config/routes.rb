Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  authenticated :user do
    root 'endpoints#index', as: :authenticated_root
  end

  resources :endpoints

  match ':uuid', to: 'endpoints#execute', via: [:post]
end
