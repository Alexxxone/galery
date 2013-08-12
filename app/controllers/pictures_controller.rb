
class PicturesController < ApplicationController
  #caches_action :get_categories
  #cache_sweeper :pictures_sweeper, :only => [:create, :get_last_comments ]
  #expire_page(:controller => "action", :action => %w( index create ))
  before_filter :get_categories
  before_filter :authenticate_user!,:only => [:edit, :new, :destroy, :create, :update,:like]
  before_filter :get_last_comments_and_users
  before_filter :set_last_request_at, :if => :user_signed_in?


  def index
    @search = Picture.order("created_at DESC").page(params[:page]).search(params[:q])
    @pictures =  @search.result
    respond_to do |format|
      format.html
      format.json { render json: @pictures }
    end
  end

  def show
   if Picture.where(id: params[:id]).first
     @all_likes = Like.where(:picture_id => params[:id]).length
     @picture = Picture.where(:id => params[:id]).first
     @comments = Comment.preload([:user,:picture]).where(:picture_id=>params[:id]).order('created_at DESC').page(params[:page])
     respond_to do |format|
       format.html
       format.js
     end
   else
      redirect_to root_path, :alert => 'No such picture.'
   end
  end

  def select
    category = Category.find_or_initialize_by_name(params[:category])
    @search = category.pictures.search(params[:id])
    @pictures = @search.result.order("created_at DESC").page params[:page]
    render :index
  end


  def like
      status =current_user.likes.where(picture_id: params[:pic_id]).first
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

   def user
     render json: {:id => current_user.id }
   end

  def chat_messages
    @incomming = Message.where("sender_id IN (?) AND receiver_id IN (?) ",["#{current_user.id}",params[:opponent_id]],[current_user.id,params[:opponent_id]])
    render json: {:incomming => @incomming }
  end



  def select_language
    if ['en','de'].include? "#{params[:language]}"
      session[:language] = params[:language]
      render :json => {ok: 'ok'}
    else
      render :json => {err: 'err'}
    end
  end

  private
  def get_categories
    @categories = Category.all
  end
  private
  def get_last_comments_and_users
    gon.current_user = current_user.try(:id) || ''
    @users = User.where(["id != #{current_user.id} AND last_request_at > ? ", 5.minutes.ago] ).order("email DESC") if current_user
    @last_comments = Comment.includes([:user,:picture]).last(5).sort_by{|e| -e[:id]}
  end
  private
  def set_last_request_at
    current_user.update_attribute(:last_request_at, Time.now)
  end

end   #end Picture Controller
