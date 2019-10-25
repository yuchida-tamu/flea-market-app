class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'フォローしました'
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = 'フォローをやめました'
    redirect_to user
  end
end
