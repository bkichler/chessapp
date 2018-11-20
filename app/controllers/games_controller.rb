class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join_as_black, :join_as_white]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @piece = Piece.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    return render_not_found if @game.nil?
    @game.update_attributes(game_params)
    redirect_to game_path(@game.id)
  end

  def join_as_black
    @game = Game.find(params[:id])
    return render_not_found if @game.nil?
    @game.update_attribute(:black_player_user_id, current_user.id)
    @game.set_player_ids
    redirect_to game_path(@game.id)
  end

  def join_as_white
    @game = Game.find(params[:id])
    return render_not_found if @game.nil?
    @game.update_attribute(:white_player_user_id, current_user.id)
    @game.set_player_ids
    redirect_to game_path(@game.id)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  privates

  def game_params
    params.require(:game).permit(:black_player_user_id, :white_player_user_id, :turn_user_id, :game_id)
  end
end
