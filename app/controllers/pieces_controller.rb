class PiecesController < ApplicationController
  def index
    render json: Piece.order(:game_id, :id)
  end

  def update
    piece = Piece.find(params[:id])
    piece.update_attributes(piece_params)
    render json: piece
  end

  private

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos)
  end
end
