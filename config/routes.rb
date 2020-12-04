Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  # /users/:id
  # /users/sign_out
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
      resources :book_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about', as: 'about'
end