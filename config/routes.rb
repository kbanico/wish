Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  resources :wishes, only: [:new, :create, :show, :index] do
    resources :donations, only: :create
    resources :comments, only: [:create, :new]
  end

  resources :users, only: [:show]

end
