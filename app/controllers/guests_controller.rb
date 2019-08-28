class GuestsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @guest = Guest.new
    @guest.user = current_user
    @guest.game = @game
    if  @game.number_players > @game.guests.count && !current_user.in_game?(@game)
      @guest.save
    end
    redirect_to game_path(@game)
  end
end
