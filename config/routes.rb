Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games, only: [:new, :create, :show, :update] do
    member do
      patch :join_as_black, :join_as_white
      put :join_as_black, :join_as_white
    end
  end
end
