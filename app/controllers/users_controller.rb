class UsersController < ApplicationController
  def index
    #list all users
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 10)
    #list buddies of the current_user
    @buddies = current_user.friends
    #list of users requested friendship to the current_user (so list of buddies to be accepted or declined)
    @requested_buddies = current_user.requested_friends
  end

  def show
    @user = User.find(params[:id])
  end
end
