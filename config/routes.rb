Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :users, only: [:show]
  resources :rooms do
    resources :chat_members, only: %w(create destroy)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
