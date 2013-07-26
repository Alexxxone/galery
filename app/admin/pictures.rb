require 'observer'
include Observable
ActiveAdmin.register Picture do

  index do
    selectable_column
    column admin_user_signed_in?
    column "filename" do |filename|
      image_tag filename.filename.url(:thumb), class: 'my_image_size'
    end
    column :likes do |like|
      like.likes.length
    end
    default_actions
  end

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "Picture Details", :multipart => true do
      f.input :title
      f.input :categories, as: :check_boxes
      f.input :filename, :as => :file
    end
    f.actions
  end

  controller do
    def scoped_collection
       Picture.preload(:likes)
    end
    def create
      super
      if  @picture.save
        cat_id = params[:picture][:category_ids]
        user_id = UserCategory.find_all_by_category_id(cat_id)
        c_id =[]
        puts user_id.map { |cat| c_id << cat.category_id  }
        u_id =[]
        puts user_id.map { |cat| u_id << cat.user_id  }
        @categories = Category.find(c_id)
        @recipients = User.find(u_id)
        UserMailer.category_email(@recipients,@categories).deliver
        changed
        notify_observers(@picture)
      end
    end
  end



end
