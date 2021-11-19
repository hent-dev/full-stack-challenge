# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: 'lends#index'

  resources :lends
  resources :books
  resources :users
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'books#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
