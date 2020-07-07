class RelationshipsController < ApplicationController
  before_action :logged_in_user
  def create
    @user = User.find_by params[:followed_id]
    if @user
      current_user.follow(@user)
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "controller.users.load_user.flash_user_nil"
      redirect_to root_path
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
