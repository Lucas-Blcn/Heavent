Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :events, only: %I[index show] do
    resources :interests, only: %I[create update]
  end
  resources :interests, only: %I[destroy]
  resources :reviews, only: %I[destroy]
  resources :interests, only: [] do
    resources :reviews, only: %I[create update]
  end
end
