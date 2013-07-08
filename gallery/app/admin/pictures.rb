ActiveAdmin.register Picture do

  form :html => {:enctype => "multipart/form-data" } do |f|
    f.semantic_errors :base
    f.inputs "Picture Details", :multipart => true do
      f.input :title
      f.input :categories, as: :check_boxes
      f.input :filename, :as => :file
    end
    f.actions
  end


end
