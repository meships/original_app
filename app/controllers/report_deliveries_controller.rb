class ReportDeliveriesController < ApplicationController
    def create
        @daily_report = DailyReport.find(params[:daily_report_id])
        @report_delivery = ReportDelivery.new(report_delivery_params)
        #binding.pry # ここに追記
        @report_delivery.daily_report_id = params[:daily_report_id]

        if @report_delivery.save
            flash[:success] = '日報を渡しました！'
            #binding.pry # ここに追記
            redirect_to daily_report_path(params[:daily_report_id])
        else
            flash.now[:danger] = '日報を渡せませんでした。'
            render 'daily_reports/show'
        end
    end
    
    private
    
    def report_delivery_params
        params.require(:report_delivery).permit(:user_id)
    end
end
