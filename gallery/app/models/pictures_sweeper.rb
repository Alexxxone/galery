class PicturesSweeper < ActionController::Caching::Sweeper #ActiveRecord::Observer
 observe Picture, Comment
 def after_create(picture)
   expire_page(:controller => "pictures", :action => %w( index create ))
 end

end










#   Notifications.comment( "New picture was posted", picture).deliver
#   expire_page(:controller => "pictures", :action => %w( show index ))
#   expire_action(:controller => "lists", :action => "all")