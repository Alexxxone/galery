ActiveAdmin.register_page "Events" do

  breadcrumb do
            [
                  link_to('events', '/admin/events')

             ]
  end
  page_action :show, :method => :get do
    @user = User.find(params[:id])
    render :layout => 'active_admin'
  end

  controller do
    def index
      @users = User.all
      render :layout => 'active_admin'
    end
  end
end