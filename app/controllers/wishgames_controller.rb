class WishgamesController < ApplicationController

  before_action :find_game
  before_action :set_wishlist
  before_action :set_wishgame, only: [:destroy]

  def create
    if already_wish?
      flash[:notice] = "You can't add a game twice to your wishlist"
    else
      Wishgame.create(wishlist_id: @wishlist.ids[0], game_id: params[:game_id])
    end
    redirect_to game_path(@game)
  end

  def already_wish?
    Wishgame.where(wishlist_id: @wishlist.ids[0], game_id:
    params[:game_id]).exists?
  end

  def destroy
    if !(already_wish?)
      flash[:notice] = "Cannot remove from your wishlist"
    else
      @wishgame.destroy
    end
    redirect_to game_path(@game)
  end

  private

  def set_wishlist
    @wishlist = Wishlist.where(user_id: current_user)
  end

  def set_wishgame
   @wishgame = @game.wishgames.find(params[:id])
  end

  def find_game
    @game = Game.find(params[:game_id])
  end
end
