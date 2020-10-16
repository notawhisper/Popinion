Rails.application.routes.draw do
  get 'rooms/index'
  get 'rooms/new'
  get 'rooms/edit'
  get 'rooms/show'
  root 'top#index'
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
