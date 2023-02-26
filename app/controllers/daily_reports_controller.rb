class DailyReportsController < ApplicationController
  before_action :login_required
  before_action :check_author, only: [:edit, :update]
  def index
    @daily_reports = current_user.daily_reports
     # 渡された日報を取得し、@daily_reportsに追加する
    @delivered_reports = current_user.report_deliveries.map(&:daily_report)
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
    #日報閲覧許可
    @users = User.all
    # @report_delivery = ReportDelivery.new
    # @report_delivery = ReportDelivery.find(params[:id])
    # @daily_report = @report_delivery.daily_report

    if params[:report_delivery_id].present?
      @report_delivery = ReportDelivery.find(params[:report_delivery_id])
      @daily_report = @report_delivery.daily_report
    else
      @report_delivery = ReportDelivery.new
    end
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

  def check_author
    @daily_report = DailyReport.find(params[:id])
    if @daily_report.user != current_user
      flash[:danger] = "他のユーザーの日報は編集できません"
      redirect_to daily_report_path(@daily_report)
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
    #redirect_to homes_top_path unless current_user
  end
end
