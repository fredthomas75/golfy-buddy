class FriendshipsController < ApplicationController
  before_action :set_user

  def request_frd
    current_user.friend_request(@user)
    redirect_to user_path(@user), notice: "Buddy request successfully sent."
  end

  def confirm_frd
    #can accept the friend request
    current_user.accept_request(@user)
    redirect_to user_path(current_user), notice: "Buddy request successfully accepted."
  end

  def decline_frd
    #can decline the friend request
    current_user.decline_request(@user)
    redirect_to user_path(current_user), notice: "Buddy request successfully declined."
  end

  def remove_frd
    # can remove from its friends
    current_user.remove_friend(@user)
    redirect_to user_path(current_user), notice: "Buddy successfully removed from your Buddy list."
  end

    private

    def set_user
      @user = User.find(params[:id])
    end
end
