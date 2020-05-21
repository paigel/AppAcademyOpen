Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :challenges
end