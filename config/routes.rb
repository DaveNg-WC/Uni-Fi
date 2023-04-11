Rails.application.routes.draw do
  get 'statement/new'
  post '/statement/new', to: 'statement#create'
  get 'statement/uploaded'


  resources :partnerships, only: [:index, :new, :create, :destroy]
  resources :budgets
  resources :transactions
  resources :categories
  resources :wallets
  devise_for :users
  root to: "pages#landing"

  resources :wallets do
    resources :transactions, only: [:index]
  end

  # get '/menu', to: 'pages#menu'
  get '/dashboard', to: 'pages#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
