Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing"

  get :landing, to: "pages#landing"
  get :form, to: "pages#form"
  get '/pages/map', to: 'pages#map', as: 'map'

  resources :events, only: %I[index show] do
    resources :interests, only: %I[create update]
  end
  #  Pas certain du destroy en dessous car je peux "supprimer" un intérêt en appuyant dessus -> change le statut en false
  resources :interests, only: %I[index destroy]
  resources :reviews, only: %I[destroy]
  resources :interests, only: %I[index] do
    resources :reviews, only: %I[create update]
  end
end
