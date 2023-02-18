class DailyReportsController < ApplicationController
  before_action :login_required
  def index
    @daily_reports = current_user.daily_reports
  end

  def new
    @daily_report = DailyReport.new
  end

  def create
    #binding.pry
    @daily_report = current_user.daily_reports.build(daily_report_params)
      if @daily_report.save

        flash[:notice] = "日報を作成しました"
        redirect_to daily_reports_path
      else
        render :new
      end
  end

  def show
    @daily_report = DailyReport.find(params[:id])
  end

  def edit
    @daily_report = DailyReport.find(params[:id])
  end

  def update
    @daily_report = DailyReport.find(params[:id])
    if @daily_report.update(daily_report_params)
      flash[:notice] = "日報を編集しました"
      redirect_to daily_reports_path
    else
      render :edit
    end
  end

  def destroy
    @daily_report = DailyReport.find(params[:id])
    if @daily_report.destroy
      flash[:notice] = "日報を削除しました"
      redirect_to daily_reports_path
    end
  end

  private

  def daily_report_params
    params.require(:daily_report).permit(:user_id, :place, :date, :address, :action_content, :tool, { label_ids: [] }, :latitude, :longitude)
  end

  def delivery_params
    params.require(:report_delivery).permit(:user_id)
  end

  # def set_daily_report
  #   @daily_report = DailyReport.find(params[:id])
  # end

  #current_user以外はログイン画面に戻す
  def login_required
    redirect_to new_session_path unless current_user
  end
end
