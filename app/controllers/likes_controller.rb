class LikesController < ApplicationController
   before_action :find_game
   before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
      users_like.destroy
    else
      @game.likes.create(user_id: current_user.id)
    end
    @users_like = users_like

    respond_to do |format|
      format.js
    end
  end

  def already_liked?
    !Like.find_by(user_id: current_user.id, game_id:
    params[:game_id]).nil?
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def users_like
    Like.find_by(user_id: current_user.id, game_id: params[:game_id])
  end

  def find_like
   @like = @game.likes.find(params[:id])
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end
