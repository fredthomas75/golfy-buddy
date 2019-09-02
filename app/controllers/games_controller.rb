class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_gb

  # GET /games
  def index
      @upcoming_games = Game.where("date >= ?", [Date.today]).order('date ASC, created_at ASC')
      @past_games = Game.where("date < ?", [Date.today]).order('date DESC, created_at DESC')
    if params[:query].present?
      @games = Game.joins(:user, :course).global_search(params[:query])
      @upcoming_games = @upcoming_games.global_search(params[:query])
      @past_games = @past_games.global_search(params[:query])
    else
      @games = Game.all
      @guests = Guest.where(game: [@games])
    end
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
        @admin.send_message(@game.user.friends, "Your buddy #{@game.user.first_name} just created a new game!", "Would you join #{@game.user.first_name}")
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

  def games_buddies
    upcoming_games = Game.where("date >= ?", [Date.today]).order('date ASC, created_at ASC')
    @upcoming_games_buddies = []
    upcoming_games.each do |upgame|
      if upgame.user.friends_with?(current_user)
        @upcoming_games_buddies << upgame
      end
    end
  end

  # GET posts/xlsx
  def xlsx
       p = Game.to_xlsx
       p.serialize('public/downloads/games.xlsx')
       send_file 'public/downloads/games.xlsx', :type=>"application/xlsx"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :options, :number_players, :number_guests, :privacy, :date, :time, :game_price, :booked, :tournament, :about_game, :course_id, :user_id)
    end
end
