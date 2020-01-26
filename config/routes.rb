Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :users, only: [:show] do
    resources :bookmarks, only: [:index]
    resource :relationships, only: [:create, :destroy] do
      collection do
        get "followers"
        get "followings"
      end
    end
  end
  resources :posts, only: [:new, :create, :destroy, :edit, :update] do
    collection do
      get "search"
    end
    resource :bookmarks, only: [:create, :destroy]
  end
  resource :user_profiles, only: [:show]
end
