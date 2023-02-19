class Admin::SessionsController < ApplicationController
    skip_before_action :login_required, only: [:guest_login]
  
    def guest_login
      user = User.find_or_create_by!(email: 'admin_guest@example.com') do |user|
        user.name = 'Guest Admin User'
        user.password = SecureRandom.urlsafe_base64
        user.admin = true
      end
      log_in user
      redirect_to admin_users_path, notice: 'ゲスト管理者としてログインしました。'
    end
end
