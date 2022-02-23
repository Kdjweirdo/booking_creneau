Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get  '/signup',  to: 'users#new'
  post   '/signup',   to: 'sessions#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  # Defines the root path route ("/")
  # root "articles#index"
end
