Rails.application.routes.draw do
  # get 'tasks/new'

  # get 'tasks/index'

  # get 'tasks/update'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    resources :tasks
  end
end
