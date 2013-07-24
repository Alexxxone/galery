class PicturesSweeper < ActionController::Caching::Sweeper #ActiveRecord::Observer
 observe Picture, Comment ,Category
 def after_create(object)
   expire_page(:controller => object.controller_name , :action => %w( index create ))
   fragment = ActionController::Caching::Fragments.new
   fragment.expire_fragment('menu')
 end



end










#   Notifications.comment( "New picture was posted", picture).deliver
#   expire_page(:controller => "pictures", :action => %w( show index ))
#   expire_action(:controller => "lists", :action => "all")