Rails.application.routes.draw do
  root "daily_reports#index"
  resources :daily_reports
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
