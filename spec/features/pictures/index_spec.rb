require 'spec_helper'



describe 'Picture', :type => :feature, :js=>true do
  include Warden::Test::Helpers

  before :each do
    Warden.test_mode!
    @user = FactoryGirl.create(:user,:email => 'one@mail.ru' ,:password => '12345678',:password_confirmation =>'12345678')
    @user2 = FactoryGirl.create(:user,:email => 'two@mail.ru' ,:password => '12345678',:password_confirmation =>'12345678')
    @cat = FactoryGirl.create(:category)
    @cat.pictures << FactoryGirl.create(:another_picture)
    @cat2 = FactoryGirl.create(:category)
    @cat2.pictures << [ FactoryGirl.create(:show),FactoryGirl.create(:show)]
    @cat3 = FactoryGirl.create(:category)
    8.times do
      @cat3.pictures << FactoryGirl.create(:show)
    end
    FactoryGirl.create(:comment,:user_id => @user.id, :picture_id => 1, :body => "My comment2")
    @comment =  FactoryGirl.create(:comment,:user_id => @user.id, :picture_id => 1, :body => "My comment1")
    FactoryGirl.create(:comment,:user_id => @user.id, :picture_id => 2)
    FactoryGirl.create(:comment,:user_id => @user2.id, :picture_id => 2)
    FactoryGirl.create(:comment,:user_id => @user2.id, :picture_id => 1)
  end

  context 'Main page' do

    it "index and change language" do
      in_browser('one') do
        visit '/pictures'
        page.should have_link('Home', :href => '/pictures')
        select('de', :from => 'Language')
        page.has_content?('Neueste Kommentare')
        current_path.should == '/pictures'
        number_of_columns = page.all(:xpath, "//li[@class='picture-box']")
        number_of_columns.length.should == 5
        within '#navigation' do
          find(:xpath, "//a[@href='/pictures/category/tit1']").click
        end
        current_path.should == '/pictures/category/tit1'
        number_of_columns = page.all(:xpath, "//li[@class='picture-box']")
        number_of_columns.length.should == 1
        within '#navigation' do
          find(:xpath, "//a[@href='/pictures/category/tit2']").click
        end
        current_path.should == '/pictures/category/tit2'
        number_of_columns = page.all(:xpath, "//li[@class='picture-box']")
        number_of_columns.length.should == 2
        find(:xpath, "//a[@href='/pictures']").click
        within ('.pagination') do
         first(:css, "a[href='/pictures/page/3']").click
        end
        current_path.should == '/pictures/page/3'
        number_of_columns = page.all(:xpath, "//li[@class='picture-box']")
        number_of_columns.length.should == 1
        number_of_columns = page.all(:xpath, "//p[@class='last_comments']")
        number_of_columns.length.should == 5
        within ('#pusher_result') do
          first(:css, "p[class='last_comments'] a").click
        end
        current_path.should == "/pictures/1"
        page.should have_content('My comment2','My comment1')
        fill_in 'comment[body]', :with=> 'new comment about big big tits'
        click_button ('Add comment')
        current_path.should == "/users/sign_in"
        page.should have_content('You need to sign in or sign up before continuing.')
        fill_in 'user[email]', :with => 'one@mail.ru'
        fill_in 'user[password]', :with => '12345678'
        click_button('Sign in')
        current_path.should == '/'
        first(:css, ".picture-box .cap-left a img").click
        current_path.should == '/pictures/11'
        fill_in 'comment[body]', :with=> 'new comment about big big tits'
        click_button ('Add comment')
        current_path.should == '/pictures/11'
        page.should have_content('new comment about big big tits','one@mail.ru')

    #it "allows chatting" do
    #  in_browser(:one) do
    #    sign_in_as "joe"
    #
    #    visit "/chat"
    #  end
    #
    #  in_browser(:two) do
    #    sign_in_as "bob"
    #
    #    visit "/chat"
    #  end
    #
    #  in_browser(:one) do
    #    page.should have_content("bob just entered the chat")
    #    add_comment "Hey Bob"
    #  end
    #
    #  in_browser(:two) do
    #    page.should have_content("Hey Bob")
    #    add_comment "Hey Joe"
    #  end
        visit '/'
      end

      in_browser('two') do
          visit '/users/sign_in'
          fill_in 'user[email]', :with => 'two@mail.ru'
          fill_in 'user[password]', :with => '12345678'
          click_button('Sign in')

      end
      in_browser('one') do
        visit '/'
      end
      in_browser('two') do
        within ('#pusher_result') do
          first(:css, "p[class='last_comments'] a").click
        end
        visit '/'
      end
      in_browser('two') do
        sleep(10)
        first(:css, '.show_private_chat').click
        fill_in 'mess',:with => 'hallo! how are you?'
        find(:css, ".sending_message_button").click

        puts Message.all.pretty_inspect
        puts Message.count.inspect
      end
      in_browser('one') do

        page.should have_content('hallo! how are you?')
        fill_in 'mess',:with => 'fine!and you?'
        find(:css, ".sending_message_button").click

        puts Message.all.pretty_inspect
        puts Message.count.inspect
      end
      in_browser('two') do
        page.should have_content('fine!and you?')
      end


  end
end
end




  #
  #  it "WRONG Post BODY" do
  #    visit '/posts'
  #    page.should have_link('New Post', :href => '/posts/new')
  #    find(:xpath, "//a[@href='/posts/new']").click
  #    current_path.should == '/posts/new'
  #    within("#new_post") do
  #      fill_in 'post_title', :with=> 'right stitle'
  #      fill_in 'post_body', :with=> 'wrong'
  #      click_button('Create Post')
  #    end
  #    current_path.should == '/posts'
  #    page.should have_content( 'Body is too short (minimum is 10 characters)')
  #  end
  #
  #  it "RIGHT New Post without tags" do
  #    visit '/posts'
  #    page.should have_link('New Post', :href => '/posts/new')
  #    find(:xpath, "//a[@href='/posts/new']").click
  #    current_path.should == '/posts/new'
  #    within("#new_post") do
  #      fill_in 'post_title', :with=> 'right titdfgle'
  #      fill_in 'post_body', :with=> 'right body about big city'*2
  #      click_button('Create Post')
  #    end
  #    current_path.should == '/posts/1'
  #  end
  #
  #  it "RIGHT new Post WITH one Tag" do
  #    visit '/posts'
  #    page.should have_link('New Post', :href => '/posts/new')
  #    find(:xpath, "//a[@href='/posts/new']").click
  #    current_path.should == '/posts/new'
  #    within("#new_post") do
  #      fill_in 'post_title', :with=> 'right tidtle new'
  #      fill_in 'post_body', :with=> 'right bodys about bigss city'*4
  #      fill_in 'post_tags_attributes_0_name', :with=> 'city'
  #      click_button('Create Post')
  #    end
  #    current_path.should == '/posts/1'
  #  end
  #  it "RIGHT new Post WITH couple Tag" do
  #    visit '/posts'
  #    page.should have_link('New Post', :href => '/posts/new')
  #    find(:xpath, "//a[@href='/posts/new']").click
  #    current_path.should == '/posts/new'
  #    within("#new_post") do
  #      fill_in 'post_title', :with=> 'right newtdditle'
  #      fill_in 'post_body', :with=> 'right bosdy abousst big city'*2
  #      fill_in 'post_tags_attributes_0_name', :with=> 'city'
  #      find(:xpath, "//button[@onclick='add_tag_form()']").click
  #      fill_in 'post_tags_attributes_1_name', :with=> 'town'
  #      click_button('Create Post')
  #    end
  #    current_path.should == '/posts/1'
  #    page.should have_content('Warning: 0')
  #    page.should have_content('Waiting to approve: 1')
  #    page.should have_link('Admin enter', :href => '/admin/dashboard')
  #    find(:xpath, "//a[@href='/admin/dashboard']").click
  #    current_path.should == '/admin/dashboard'
  #    find(:xpath, "//a[@href='/admin/posts/1/edit']").click
  #    current_path.should == '/admin/posts/1/edit'
  #    select('Write message', :from => 'post_confirmed')
  #    fill_in 'comments_body', :with=> "please change title from 'right newtdditle' to 'new title' "
  #    find(:xpath, "//a[@onclick='admin_send_comment()']").click
  #    click_button ('Update Post')
  #    current_path.should == '/admin/posts/1'
  #    visit '/posts'
  #    page.should have_content('Warning: 1')
  #    page.should have_content('Waiting to approve: 0')
  #    find(:xpath, "//a[@href='/posts/wait']").click
  #    current_path.should == '/posts/wait'
  #    find(:xpath, "//a[@href='/posts/1']", :text =>'Show').click
  #    current_path.should == '/posts/1'
  #    page.should have_content("please change title from 'right newtdditle' to 'new title'")
  #    find(:xpath, "//a[@href='/posts/1/edit']").click
  #    current_path.should == '/posts/1/edit'
  #    fill_in 'post_title', :with=> 'new title about big big city'
  #    click_button('Create Post')
  #    current_path.should == '/posts/1'
  #    fill_in 'comment_body', :with=>'i change title'
  #    click_button ('Add comment')
  #    page.should have_content ('Comment was successfully created.')
  #    visit '/admin/'
  #    find(:xpath, "//a[@href='/admin/posts/1/edit']").click
  #    current_path.should == '/admin/posts/1/edit'
  #    select('Yes', :from => 'post_confirmed')
  #    click_button ('Update Post')
  #    current_path.should == '/admin/posts/1'
  #    visit '/posts'
  #    page.should have_content (' Approved: 1')
  #    page.should have_content ('Waiting to approve: 0')
  #    page.should have_content ('Warning: 0')
  #    page.should have_content ('new title')
  #    page.should have_content ('right bosdy abousst big city'*2)
  #    page.should have_content ('city')
  #    page.should have_content ('town')
  #    find(:xpath, "//a[@href='/posts/1']", :text =>'Destroy').click
  #    page.should have_content (' Approved: 0')
  #    page.should have_content ('Waiting to approve: 0')
  #    page.should have_content ('Warning: 0')
  #    page.should_not have_content ('new title')
  #    page.should_not have_content ('right bosdy abousst big city'*2)
  #  end
  #end

  #
  #context 'Register and back to index' do
  #  it "post_path" do
  #    visit "/posts"
  #    page.should have_link('Sign up', :href => '/users/sign_up')
  #    find(:xpath, "//a[@href='/users/sign_up']").click
  #
  #    within("#new_user") do
  #      fill_in 'user_email', :with=> 'test@mail.ru'
  #      fill_in 'user_password', :with=> '123456'
  #      fill_in 'user_password_confirmation', :with=> '123456'
  #      click_button('Sign up')
  #    end
  #    current_path.should == '/users'
  #  end
  #end

  #context 'Sign out and back to index' do
  #  it "post_path" do
  #    visit('/posts')
  #    page.should have_link('Sign out', :href => '/users/sign_out')
  #    find(:xpath, "//a[@href='/users/sign_out']").click
  #    page.should have_content( 'Signed out successfully.')
  #    current_path.should == '/'
  #  end
  #end





#end


#find(".b-form__select-value").click
#find("#b-form").click

# METHOD GET
#/people?search=name"
#uri = URI.parse(current_url)
#"#{uri.path}?#{uri.query}".should == people_path(:search => 'name')



#visit post_path
#fill_in - текстовое поле через селектор
#select выпадающие списки
#check  check_button
#choose radio_button
#
#within 'navigation' do
#  check selector
#end
#
#page.should.have.content
#
#
#click button
#click link
#current_page.should be :show
#
#click link