Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show] do
    resources :bookmarks, only: [:index]
    resources :relationships, only: [:create, :destroy]
  end
  resources :posts, only: [:new, :create, :destroy, :edit, :update] do
    resources :bookmarks, only: [:create, :destroy]
  end
end
