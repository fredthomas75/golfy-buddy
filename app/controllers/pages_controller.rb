class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # if params[:query].present?
      @city = request.location.city
      @games = Game.all
      @upcoming_games_nearby = Game.upcoming.joins(:course).where("address ILIKE '%#{@city}%'").limit(5).order(:date)
      raise
    end
end
