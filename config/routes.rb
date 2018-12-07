Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games do
    member do
      patch :join_as_black, :join_as_white
      put :join_as_black, :join_as_white
    end
    resources :pieces do
      member do
        patch :move
        put :move
      end
    end
  end
end
