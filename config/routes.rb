Gallery::Application.routes.draw do
  root :to => 'pictures#index'

  post '/messages/send' => 'messages#create'

  post 'categories/subscribe' => 'categories#subscribe'
  post 'categories/check_subscribe' => 'categories#check_subscribe'

  get '/pusher/auth' => 'pusher#auth'
  match 'auth/failure', to: redirect('/')
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => {:registrations => "registrations", :sessions => 'sessions'}
  devise_scope :users do
    get '/auth/:provider/callback' =>  'sessions#facebook'
  end
  post "/admin/parser/create_picture" => "admin/parser#create_picture"
  resources :pictures ,only: [:show]
  resources :pictures,  path_names: { select: 'category' },only: [:select,:index] do
    collection do
      post 'select_language', :action => :select_language
      post 'chat_messages', :action => :chat_messages
      post 'user' , :action => :user
      post 'like', :action => :like
      get '/category/:category', :action => :select
      get 'page/:page', :action => :index
      get '/category/:category/:page', :action => :select
      post :search, :action => :index
    end
    resources :comments , only: :create
  end

end

