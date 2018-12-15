class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @all_games = open_games
    @open_games = open_games
  end

  def all_games
    if user_signed_in?
      @played_games = Game.where('black_player_user_id = ? or white_player_user_id = ?', current_user.id, current_user.id).order('updated_at').to_a.first
    end
  end

  def open_games
    if user_signed_in?
      @open_games = Game.where('black_player_user_id = ? or white_player_user_id = ?', nil, nil).first
    end
  end

end
