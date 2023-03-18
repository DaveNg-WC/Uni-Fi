Rails.application.routes.draw do
  resources :budgets
  resources :transactions
  resources :categories
  resources :wallets, only: %i[index new create update destroy]
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
