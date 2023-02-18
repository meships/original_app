Rails.application.routes.draw do
  get 'daily_reports/index'
  get 'daily_reports/new'
  get 'daily_reports/show'
  get 'daily_reports/edit'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
