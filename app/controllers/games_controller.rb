class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :upcoming, :past, :public_games]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_gb

  # GET /games
  def index
    # @games = Game.upcoming
      # @upcoming_games = Game.where("date >= ?", [Date.today]).order('time ASC, created_at ASC')
      # @past_games = Game.where("date < ?", [Date.today]).order('time DESC, created_at DESC')

      # if user_signed_in?
      #   @wishlist = Wishlist.where(user_id: current_user.id)
      #   @wishgames = Wishgame.where(wishlist_id: @wishlist.ids[0])
      #   @games_wish = []
      #   @wishgames.each do |wish|
      #     @games_wish << wish.game
      #   end
      # end

    # if params[:game_query].present?
    #   query_date = Date.parse(params[:game_query][:date])
    #   # query_location = params[:game_query][:location]
    #   @games_by_date = Game.where("time > ? AND time < ?", query_date, query_date + 1)
    #   # @games = @games_by_date.select { |game| ("#{game.course.address} ILIKE %#{query_location}%") }

    # # elsif params[:query].present?
    # #   @games = Game.joins(:user, :course).global_search(params[:query])
    # #   @upcoming_games = @upcoming_games.global_search(params[:query])
    # #   @past_games = @past_games.global_search(params[:query])
    # else
      (@filterrific = initialize_filterrific(
        Game,
        params[:filterrific],
        select_options: {
          sorted_by: Game.options_for_sorted_by,
          with_course_id: Course.options_for_select_course,
          with_date: Game.options_for_select,
        },
        )) || return
          @games = @filterrific.find.page(params[:page]).where('time >= ?', [Date.today])
      respond_to do |format|
        format.html
        format.js
      end
      # @guests = Guest.where(game: [@games])
    # end
  end

  def upcoming
    @games = Game.upcoming.map do |game|
      unless game.number_guests.nil?
      game.guests.size < game.number_guests
      end
    end
    # @games = @games.paginate(page: params[:page])
    render :index
  end


  def with_address
    @games = Game.with_address
    render :index
  end

  def past
    @games = Game.past
    render :index
  end

  def public_games
    @games = Game.public_games
    render :index
  end

  def play_more
    @games = Game.play_more
    render :index
  end

  # GET /games/1
  def show
    @attachments = @game.attachments.all
    @guest = @game.guests.find_by(user: current_user)
    @user = User.find(@game.user.id)
    @marker = [{
      lat: @game.course.latitude,
      lng: @game.course.longitude,
      image_url: helpers.asset_url('marker-gb.png')
    }]
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
    @game.location = @game.course.address
    @game.country = @game.course.country
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
      @game.location = @game.course.address
      @game.country = @game.course.country
      @game.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :options, :number_players, :number_guests, :privacy, :date, :time, :game_price, :booked, :tournament, :about_game, :course_id, :user_id, :location, :country)
    end
end
