class PiecesController < ApplicationController
  before_action :set_game!

  def index
    render json: @game.pieces
  end

  def update
    piece = @game.pieces.find(params[:id])
    piece.update_attributes(piece_params)
    render json: piece
  end

  private

  def set_game!
    @game = Game.find(params[:game_id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos)
  end
end
