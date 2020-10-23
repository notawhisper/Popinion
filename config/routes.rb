Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :users, only: [:show]
  resources :rooms do
    member do
      get '/pdf-download', to: 'rooms#download', format: 'pdf'
      get '/assign_code_number', to: 'rooms#set_code_numbers'
    end
    resources :chat_members, only: %w(create destroy)
    resources :posts, only: %w(create)
  end
  resources :groups do
    resources :members, only: %w(create destroy), controller: 'group_members'
  end
end
