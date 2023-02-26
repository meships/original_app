class Admin::UsersController < ApplicationController
    before_action :admin_user

    def index
        @users = User.all.includes(:daily_reports)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to user_path(@user.id)
        else
          render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "情報を編集しました！"
            redirect_to daily_reports_path
        else
            render :edit
        end
    end

    def show
        @user = User.find(params[:id])
    end

    # def destroy
    #     @user = User.find(params[:id])
    #     @user.destroy
    #     flash[:notice] = "ユーザーを削除しました"
    #     redirect_to admin_users_path
    # end

    def destroy
        @user = User.find(params[:id])
        if @user.guest? || @user.admin_guest?
          flash[:error] = "ゲストユーザーまたは管理者ゲストは削除できません"
          redirect_to admin_users_path
        else
          @user.destroy
          flash[:success] = "ユーザーを削除しました"
          redirect_to admin_users_path
        end
      end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def admin_user
      unless logged_in? && current_user.admin?
          flash[:notice] = "管理者以外はアクセス不可"
          #redirect_to new_session_path
          redirect_to homes_top_path
      end
    end
end
