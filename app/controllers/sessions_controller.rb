class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :guest_login, :admin_guest_login]
  def new
    redirect_to user_path(current_user.id) if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end




  def guest_login
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'Guest User'
      user.password = SecureRandom.urlsafe_base64
    end
    log_in user
    redirect_to daily_reports_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_guest_login
    user = User.find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.name = 'Guest Admin User'
      user.password = SecureRandom.urlsafe_base64
      user.admin = true
    end
    log_in user
    redirect_to admin_users_path, notice: 'ゲスト管理者としてログインしました。'
  end
end
