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

  def set_preferences
    current_user.user_preferences.delete_all
    list = get_list_pref
    list.each do |l|
      UserPreference.create!(user: current_user, list_pref: l)
    end
    redirect_to user_path(current_user), notice: "Preferences successfully set."
  end

  def set_personalities
    current_user.user_personalities.delete_all
    raise
    list = get_list_pref
    list.each do |l|
      UserPersonality.create!(user: current_user, list_pref: l)
    end
    redirect_to user_path(current_user), notice: "Personality successfully set."
  end

  def new_preferences
  end

  def new_personalities
  end

  private

  def get_list_pref
    perso_id = params[:current_user][:list_pref_ids]
    list = perso_id.map do |id|
      ListPref.find(id)
    end
  end

end
