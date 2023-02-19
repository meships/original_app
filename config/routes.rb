Rails.application.routes.draw do

  root "daily_reports#index"

  #日報 写真 コメント
  resources :daily_reports do
    resources :report_deliveries
    resources :photos do
      resources :photo_comments
    end    
  end

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

  #日報を渡す
  post '/daily_reports/:id/share', to: 'daily_reports#share', as: 'share_daily_report'
end
