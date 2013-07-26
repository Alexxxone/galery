Gallery::Application.routes.draw do

  post '/messages/send' => 'messages#create'

  post 'categories/subscribe' => 'categories#subscribe'
  post 'categories/check_subscribe' => 'categories#check_subscribe'

  post 'pictures/' => 'pictures#search'
  post '/pictures/select_language' => 'pictures#select_language'
  post '/pictures/chat_messages' => 'pictures#chat_messages'
  post '/pictures/user' => 'pictures#user'
  post 'pictures/like' =>'pictures#like'

  get '/pusher/auth' => 'pusher#auth'
  match 'auth/failure', to: redirect('/')

  devise_for :users, :controllers => {:registrations => "registrations",:sessions=>'sessions'}do
    get '/auth/:provider/callback' =>  'sessions#facebook'
  end

  root :to => 'pictures#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post "/admin/parser/create_picture" => "admin/parser#create_picture"

  resources :pictures, path_names: { select: 'category'}  do
    get '/category/:category', :action => :select, :on => :collection
    get '/page/:page', :action => :index, :on => :collection
    resources :comments , only:[:create,:show]
  end

end

