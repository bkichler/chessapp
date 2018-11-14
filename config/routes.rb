Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games, only: [:new, :create, :show, :update]
  resources :pieces, only: [:create, :show, :update]
end
