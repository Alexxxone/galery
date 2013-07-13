class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def subscribe
     current_sub =  current_user.user_categories.where(category_id: params[:cat_id])
    if current_sub.blank?
        UserCategory.create(user_id: current_user.id,category_id: params[:cat_id])
        render json:{res:1}
    else
        UserCategory.where(user_id: current_user.id,category_id: params[:cat_id]).delete_all
        render json: {}
    end
  end

  def check_subscribe
    render json: current_user.user_categories.all
  end
end
