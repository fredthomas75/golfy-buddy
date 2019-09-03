class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # if params[:query].present?
      @games = Game.all
    end
end
