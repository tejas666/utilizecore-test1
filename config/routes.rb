Rails.application.routes.draw do
  resources :service_types
  resources :parcels
  resources :addresses
  resources :users
  # root to: 'parcels#index'
  root to: 'sessions#new' 
  get '/search', to: 'search#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout_user'
  get '/admin/reports', to: 'reports#view_report', defaults: { format: :xlsx }, as: 'admin_reports'


# Registration routes for new user creation
  get 'signup', to: 'users#new', as: 'signup_user'
  post 'signup', to: 'users#create' 
  get 'generate_report', to: 'reports#generate_report'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
