Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  resources :wishes, only: [:new, :create, :show, :index]
end
