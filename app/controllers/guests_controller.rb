class GuestsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    # raise
    @guest = Guest.new
    @guest.user = current_user
    @guest.game = @game
    @guest.save if  @game.number_guests > @game.guests.count
    redirect_to game_path(@game)
  end
end
