Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing"

  # get :landing, to: "pages#landing"
  get :form, to: "pages#form"
  get '/pages/map', to: 'pages#map', as: 'map'

  resources :events, only: %I[index show] do
    resources :interests, only: %I[create update]
  end
  resources :interests, only: %I[index destroy] do
    member do
      get '/favorite', to: "interests#favorite"
    end
  end

  resources :reviews, only: %I[destroy]
  resources :interests, only: %I[index] do
    resources :reviews, only: %I[create update]
  end
end
