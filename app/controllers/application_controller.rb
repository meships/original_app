class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path unless current_user || guest_user
  end

  def guest_user
    User.find_by(email: 'guest@example.com')
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
