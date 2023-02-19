class PhotosController < ApplicationController
    before_action :login_required

    def index
      @daily_report = DailyReport.find(params[:daily_report_id])
      @photos = Photo.all
    end
  
  
    def new
      @daily_report = DailyReport.find(params[:daily_report_id])
      @photo = Photo.new
    end
    
  
    def create
      @daily_report = DailyReport.find(params[:daily_report_id])
      @photo = @daily_report.photos.build(photo_params)
      if @photo.save
        # redirect_to daily_report_photo_path(@daily_report,@photo)
        redirect_to daily_report_photos_path
      end
    end
    
  
    def show
      @daily_report = DailyReport.find(params[:daily_report_id])
      @photo = Photo.find(params[:id])
      #@photo = @daily_report.photos.find(params[:id])
      @photo_comments = @photo.photo_comments
      @photo_comment = @photo.photo_comments.build
    end
  
    # def show
    #   @daily_report = DailyReport.find(params[:daily_report_id])
    #   @photo = @daily_report.photos.find(params[:id])
    #   @photo_comments = @photo.photo_comments
    #   @photo_comment = @photo.photo_comments.build
    # end
  
  
    def edit
      #@daily_report = DailyReport.find(params[:daily_report_id])
      @photo = Photo.find(params[:id]) 
      @daily_report = @photo.daily_report
    end
  
    def update
      @photo = Photo.find(params[:id])
      if @photo.update(photo_params)
        redirect_to daily_report_photo_path
      end
  
      #添付画像を個別に削除
      if params[:photo][:image_ids]
        params[:photo][:image_ids].each do |image_id|
          image = @photo.images.find(image_id)
          image.purge
        end
      end
    end
  
    def destroy
      @photo = Photo.find(params[:id])
      if @photo.destroy
        flash[:notice] = "日報を削除しました"
        redirect_to daily_report_photos_path
      end
    end
  
    private
  
    def photo_params
        params.require(:photo).permit(:title, images: [])
    end
  
    #current_user以外はログイン画面に戻す
    def login_required
      redirect_to new_session_path unless current_user
    end
    
end
