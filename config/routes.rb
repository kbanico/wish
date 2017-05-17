Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  resources :wishes, only: [:new, :create, :show, :index] do
    resources :donations, only: :create
    resources :comments, only: [:create, :new]
  end

  resources :users, only: [:show]
  resources :upload_photos

  get "/addcoins" => "static_pages#add_coins"

end
