# Welcome to Gallery
With this gallery you can login through you facebook account, subscribe to specific category of pictures(and receive email when admin add a new picture to subscribed category),
 like pictures, receive last comment(without reloading page),chat with online users in private chat

## Information
Ruby 2.0.0-p247,
Rails 3.2.13,
Postgresql,
Puma

##To go to admin panel
 go to main page, and in right bottom corner will be link to admin enter

## For upload many pictures at ones ->
 In `db/seed/pic_dir` create folders(witch name will be category name) or use old,and copy pictures inside folders,then run `rake picture`

##Gallery use real Pusher account, so please change settings in:
1) `/config/ititializers/pusher.rb`
2) `/app/assets/javascripts/pictures.js.coffee`

##Gallery use Facebook account, so please change settings in:
1) `/config/ititializers/omiauth.rb`
