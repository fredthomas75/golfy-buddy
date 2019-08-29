class FriendshipsController < ApplicationController
  before_action :set_user
  before_action :set_admin_gb

  def request_frd
    current_user.friend_request(@user)
    redirect_to user_path(@user), notice: "Buddy request successfully sent."
    #send a message to @user to inform that someone wants to be its friend
    @admin.send_message(@user, "This is a notif - Request", "#{current_user.first_name} #{current_user.last_name} wants to be your buddy")
  end

  def confirm_frd
    #can accept the friend request
    current_user.accept_request(@user)
    redirect_to user_path(current_user), notice: "Buddy request successfully accepted."
    #send a message to @user to inform that someone wants to be its friend
    @admin.send_message(@user, "This is a notif - Confirm", "#{current_user.first_name} #{current_user.last_name} confirms your buddy-ship!")
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
