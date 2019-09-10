class GuestsController < ApplicationController
  before_action :set_admin_gb
  before_action :find_guest, only: [:destroy]
  before_action :find_game, only: [:create, :approve_user]

  def create

    respond_to do |format|
      format.js {flash.now[:success] = "Congrats! You just joined the game: #{@game.name}"}
    end
    if already_guest?
      user_guest.destroy
    else
      @game.number_players > @game.guests.count && !current_user.in_game?(@game)
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
      # flash.now[:success] = "Congrats! You just joined the game: #{@game.name}"
    end
  end

    def already_guest?
      !Guest.find_by(user_id: current_user.id, game_id: params[:game_id]).nil?
    end

  def approve_user
    @guest.status = "confirmed"
    if @guest.save
      @admin.send_message(@guest, "You just joined #{@guest.game.name} !", "#{@guest.game.user.first_name} confirms your participation to #{@guest.game.name}")
    end
    redirect_to request.referrer
  end

  def destroy
    @guest.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def user_guest
    Guest.find_by(user_id: current_user.id, game_id: params[:game_id])
  end

  def find_guest
   @guest = @game.guests.find(params[:id])
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end



