class LikesController < ApplicationController
   before_action :find_game
   before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @game.likes.create(user_id: current_user.id)
    end
    redirect_to game_path(@game)
  end

  def already_liked?
    Like.where(user_id: current_user.id, game_id:
    params[:game_id]).exists?
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end

  def find_like
   @like = @game.likes.find(params[:id])
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

end
