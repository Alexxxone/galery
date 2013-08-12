require "spec_helper"

describe PicturesController do
  describe "routing" do

    it "routes to #index" do
      get("/pictures").should route_to("pictures#index")
    end

    it "routes to #show" do
      get("/pictures/1").should route_to("picture", :id => "1")
    end

    it "routes to #index search" do
      post("/pictures/search").should route_to("pictures#index")
    end
    it "routes to #index search and pagination" do
      get("/pictures/page/2?q%5Btitle_cont%5D=cat").should route_to("pictures#index",Parameters: {"q"=>{"title_cont"=>"cat"}, "page"=>"2"})
    end
    it "routing a named route search_pictures_path" do
        {:post => search_pictures_path}.should route_to(:controller => "pictures", :action => "index")
    end
    it "routes to #select_language" do
      post('/pictures/select_language').should route_to('pictures#select_language')
    end

    it "routes to #chat_messages" do
      post('/pictures/chat_messages').should route_to('pictures#chat_messages')
    end

    it "routes to #user" do
      post('/pictures/user').should route_to('pictures#user')
    end

    it "routes to #like" do
      post('/pictures/like').should route_to('pictures#like')
    end

    it "routes to #select" do
      get('pictures/category/cats').should route_to('pictures#select',:category => 'cats')
    end

    it "routes to #index" do
      get('/pictures/page/2').should route_to('pictures#index',:page => '2')
    end

    it "routes to #select" do
      get('pictures/category/cats/3').should route_to('pictures#select',:page => '3', :category => 'cats' )
    end

    it "routes to #create" do
      post('/pictures/1/comments').should route_to('comments#create',:picture_id => '1')
    end


  end
end
