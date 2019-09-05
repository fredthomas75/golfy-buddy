class GuestsController < ApplicationController
  before_action :set_admin_gb

  def create
    @game = Game.find(params[:game_id])
    if @game.guests.find_by(user: current_user)
      @game.guests.find_by(user: current_user).destroy!
    elsif  @game.number_players > @game.guests.count && !current_user.in_game?(@game)
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
      @guest.save
    end

    respond_to do |format|
      format.js
    end

  end

  def approve_user
    @guest = Guest.find_by(user_id: params[:id])
    @guest.status = "confirmed"
    if @guest.save
      @admin.send_message(@guest, "You just joined #{@guest.game.name} !", "#{@guest.game.user.first_name} confirms your participation to #{@guest.game.name}")
    end
    redirect_to request.referrer
  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to game_path(@guest.game)
  end

end



