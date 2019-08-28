class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.all
    @upcoming_games = Game.where("date >= ?", [Date.today]).order('date ASC, created_at ASC')
  end

  # GET /games/1
  def show
    @attachments = @game.attachments.all
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end


  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user = current_user

      if @game.save
        redirect_to @game, notice: 'Game was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /games/1
  def update
      if @game.update(game_params)
        redirect_to @game, notice: 'Game was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
      redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :options, :number_players, :number_guests, :date, :time, :game_price, :booked, :tournament, :about_game, :course_id, :user_id)
    end
end
