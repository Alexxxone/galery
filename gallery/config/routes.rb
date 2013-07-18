Gallery::Application.routes.draw do
  get 'pictures/select' => 'pictures#select'

  post 'categories/subscribe' => 'categories#subscribe'
  post 'categories/check_subscribe' => 'categories#check_subscribe'
  post 'pictures/' => 'pictures#search'



  devise_for :users, :controllers => {:registrations => "registrations",:sessions=>'sessions'}do
    get '/auth/:provider/callback' =>  'sessions#facebook'
  end

  root :to => 'pictures#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post "/admin/parser/create_picture" => "admin/parser#create_picture"

  resources :categories do
    resources :pictures , only:[:index,:show]
  end
  resources :pictures  do
    resources :comments , only:[:create,:show]
  end

  post 'pictures/like' =>'pictures#like'

  match 'auth/failure', to: redirect('/')

end
