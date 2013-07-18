class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  before_filter :authenticate_user!,:only => [:edit, :new, :destroy, :create, :update,:like]
  before_filter :get_last_comments,:get_categories
  before_filter :tracking, :except => [:like]

  def index
    @pictures = Picture.order(:created_at).page params[:page]
    session[:return_to] = request.fullpath
    respond_to do |format|
      format.html
      format.json { render json: @pictures }
    end
  end
  def search
    @pictures = Picture.where("title LIKE ?", "%#{params[:picture][:title]}%").order(:created_at).page params[:page]
    render :index
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def select
    category = Category.find_or_initialize_by_name(params[:id])
    @search = category.pictures.search(params[:search])
    @pictures = @search.result.order(:created_at).page params[:page]
    render :index
  end

  def get_categories
    @categories = Category.all
  end
  def get_last_comments
    @last_comments = Comment.last(5).sort_by{|e| -e[:id]}
  end
  def like
      status =current_user.likes.where(picture_id: params[:pic_id])
      if params[:check]
        json=status.blank? ? 0.3 : 1
      else
        if status.blank?
         like =  Like.create(:user_id=>current_user.id,:picture_id=>params[:pic_id])
          tracking("pictures.like", {:like => like,:user_id=>current_user.id} )
          json=1
        else
          Like.where("user_id = ? AND picture_id= ?",current_user.id,params[:pic_id]).destroy_all
          json=0.3
        end
      end
      all_likes = Like.where(:picture_id =>params[:pic_id]).count
      render :json => {:like => json,:all_likes=>all_likes}, layout: false
  end

  private
  def tracking (type='track_url',data = {:url=>request.url,:user_id=> current_user})
    ActiveSupport::Notifications.instrument(type,data) if !current_user.nil?
  end

end   #end Picture Controller
