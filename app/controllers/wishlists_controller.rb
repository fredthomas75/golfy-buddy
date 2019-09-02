class WishlistsController < ApplicationController

  def index
    @wishlists = Wishlist.all
  end

  def show
    @wishlist = Wishlist.find(params[:id])
    @list_games_wish = find_games
  end

  private

  def find_wishlist
   @wishlist = Wishlist.find(params[:id])
  end

  def find_games
    @wish_games = []
    @wishlist.wishgames.each do |wish|
      @wish_games << wish
    end
    @wish_games_list = []
    @wish_games.each do |wish|
      @wish_games_list << wish.game
    end
    return @wish_games_list
  end

end
