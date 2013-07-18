ActiveAdmin.register User do


  breadcrumb do
    [
      link_to('events', '/admin/events')
    ]
  end


  index  do

    column :email
    column "navigation" do  |id|
      link_to "navigation",admin_user_path(id,url:"Url")
    end
    column "likes" do |id|
      link_to "likes",admin_user_path(id,url:"Like")
    end
    column "comments" do |id|
      link_to "comments",admin_user_path(id,url:"Comment")
    end
    column "user sign in" do |id|
      link_to "sign_in",admin_user_path(id,url:"sign_in")
    end
    column "user sign out" do |id|
      link_to "sign_out",admin_user_path(id,url:"sign_out")
    end
  end

  controller do
    def show
      @events = Event.find_all_by_user_id_and_eventable_type(params[:id],params[:url])
      render '_event',layout: 'active_admin'
    end
  end


  #member_action :show, :method => :get do
  #  @user = User.find(params[:id])
  #  render :partial => '/admin/events/event',:layout => true
  #  render :layout => 'active_admin',layout: false
  #end


end


