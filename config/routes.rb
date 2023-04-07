Rails.application.routes.draw do
  get 'statement/new'
  post '/statement/new', to: 'statement#create'
  get 'statement/uploaded'


  resources :partnerships, only: [:index, :new, :create, :destroy]
  resources :budgets
  resources :transactions
  resources :categories
  resources :wallets #, only: %i[index new create update destroy]
  devise_for :users
  root to: "pages#home"

  resources :wallets do
    resources :transactions, only: [:index]
  end

  get 'landing', to: 'pages#landing'
  get '/menu', to: 'pages#menu'
  get '/dashboard', to: 'pages#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
