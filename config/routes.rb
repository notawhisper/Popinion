Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :users, only: [:show]
  resources :rooms do
    member do
      get '/pdf-download', to: 'rooms#download', format: 'pdf'
    end
    resources :chat_members, only: %w(create destroy)
    resources :posts, only: %w(create)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
