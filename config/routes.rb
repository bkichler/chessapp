Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games do
    member do
      patch :join_as_black, :join_as_white
      put :join_as_black, :join_as_white
      post :move
    end
    resources :pieces
  end
  resources :pieces, only: [:update]

  # get '/move', to: 'game#move',
end
