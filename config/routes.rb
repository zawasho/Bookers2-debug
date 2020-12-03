Rails.application.routes.draw do
  # /users/:id
  # /users/sign_out
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books
  get 'home/about' => 'homes#about', as: 'about'
end