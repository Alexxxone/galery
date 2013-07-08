class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  before_filter :authenticate_user!,:only => [:edit, :new, :destroy, :create, :update,:like]
  before_filter :get_categories
  def index
    @test =Rake::Task["ask"].execute
    @pictures = Picture.order(:created_at).page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@pictures,@test] }
    end
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
    categories = Category.find_by_name(params[:id])
    @pictures = categories.pictures.order(:created_at).page params[:page]
    render :index
  end

  def get_categories
    @categories = Category.all
    @categories.blank? ? @categories=Category.create(:name=>'test') : @categories
  end

  def like
      status =current_user.likes.where(picture_id: params[:pic_id])
      if params[:check]
        json=status.blank? ? 0.3 : 1
      else
        if status.blank?
          Like.create(:user_id=>current_user.id,:picture_id=>params[:pic_id])
         json=1
        else
          Like.where("user_id = ? AND picture_id= ?",current_user.id,params[:pic_id]).delete_all
          json=0.3
        end
      end
      all_likes = Like.count(params[:pic_id])
      render :json => {:like => json,:all_likes=>all_likes}, layout: false
    end




end   #end Picture Controller

#
## GET /pictures/new
## GET /pictures/new.json
#def new
#  @picture = Picture.new
#  @picture.comments.build
#  respond_to do |format|
#    format.html # new.html.erb
#    format.json { render json: @picture }
#  end
#end
#
## GET /pictures/1/edit
#def edit
#  @picture = Picture.find(params[:id])
#
#end
#
## POST /pictures
## POST /pictures.json
#def create
#  @picture = current_user.picture.new(params[:picture])
#
#  respond_to do |format|
#    if @picture.save
#      format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
#      format.json { render json: @picture, status: :created, location: @picture }
#    else
#      format.html { render action: "new" }
#      format.json { render json: @picture.errors, status: :unprocessable_entity }
#    end
#  end
#end
#
## PUT /pictures/1
## PUT /pictures/1.json
#def update
#  @picture = Picture.find(params[:id])
#
#  respond_to do |format|
#    if @picture.update_attributes(params[:picture])
#      format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
#      format.json { head :no_content }
#    else
#      format.html { render action: "edit" }
#      format.json { render json: @picture.errors, status: :unprocessable_entity }
#    end
#  end
#end
#
## DELETE /pictures/1
## DELETE /pictures/1.json
#def destroy
#  @picture = Picture.find(params[:id])
#  @picture.destroy
#
#  respond_to do |format|
#    format.html { redirect_to pictures_url }
#    format.json { head :no_content }
#  end
#end
