class PhotoCommentsController < ApplicationController
  before_action :login_required
  # コメントを保存、投稿するためのアクションです。
  def create
    # Photoをパラメータの値から探し出し,Photoに紐づくphoto_commentsとしてbuildします。
    @photo = Photo.find(params[:photo_id])
    @photo_comment = @photo.photo_comments.build(photo_comment_params)
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @photo_comment.save
        format.js { render :index }
        #format.html { redirect_to blog_path(@photo) }
      else
        format.html { redirect_to blog_path(@photo), notice: '投稿できませんでした...' }
      end
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = @photo.photo_comments.build
    @photo_comments = @photo.photo_comments
  end

  def edit
    @daily_report = DailyReport.find(params[:daily_report_id])
    @photo = Photo.find(params[:photo_id])
    @photo_comment = @photo.photo_comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @photo = Photo.find(params[:photo_id])
    @photo_comment = @photo.photo_comments.find(params[:id])
      respond_to do |format|
        if @photo_comment.update(photo_comment_params)
          flash.now[:notice] = 'コメントが編集されました'
          format.js { render :index }
        else
          flash.now[:notice] = 'コメントの編集に失敗しました'
          format.js { render :edit }
        end
      end
  end

  def destroy
    @photo_comment = PhotoComment.find(params[:id])
    @photo_comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private
  # ストロングパラメーター
  def photo_comment_params
    params.require(:photo_comment).permit(:comment)
  end
  # def set_blog
  #   @photo = Photo.find(params[:photo_id])
  # end

  #current_user以外はログイン画面に戻す
  def login_required
    redirect_to new_session_path unless current_user
  end
  
end
