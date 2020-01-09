Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show] do
    resources :bookmarks, only: [:index]
    resource :relationships, only: [:create, :destroy]
  end
  resources :posts, only: [:new, :create, :destroy, :edit, :update] do
    resource :bookmarks, only: [:create, :destroy]
  end
end
