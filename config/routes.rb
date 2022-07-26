Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  resources :users, only: [:index,:new,:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy,:update]
  end
end
