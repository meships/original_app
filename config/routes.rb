Rails.application.routes.draw do
  root "daily_reports#index"

  #日報
  resources :daily_reports

  #ログイン
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  #管理者
  namespace :admin do
    resources :users
    post 'guest_login', to: 'sessions#guest_login'
  end
  
  # ゲストログイン
  post '/login/guest_login', to: 'sessions#guest_login'
  post '/admin/guest_login', to: 'admin/sessions#guest_login'
end
