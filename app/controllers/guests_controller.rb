class GuestsController < ApplicationController
  before_action :set_admin_gb
  def create
    @game = Game.find(params[:game_id])
    @guest = Guest.new
    @guest.user = current_user
    @guest.game = @game
    @guest.share_of_price = @game.game_price/@game.number_players
    if @game.privacy == "public with invite"
      @guest.status = "pending"
      @admin.send_message(@game.user, "Join request", "#{@guest.user.first_name} wants to join #{@game.name}")
    elsif @game.privacy == "public"
      @guest.status = "confirmed"
    end
    if  @game.number_players > @game.guests.count && !current_user.in_game?(@game)
      @guest.save
    end
    redirect_to game_path(@game)
  end
  def approve_user
    # raise
    @guest = Guest.find_by(user_id: params[:id])
    @guest.status = "confirmed"
    @guest.save
    redirect_to request.referrer

  end

end
