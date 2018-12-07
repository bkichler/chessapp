class PiecesController < ApplicationController
  
  def index
    render json: Piece.order(:id)
  end  
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @game = Game.find(params[:id])
    @piece = @game.pieces
  end

  def update
    piece = Piece.find(params[:id])
    piece.update_attributes(piece_params)
    render json: piece
  end

  def move

  end

  private

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos)
  end
end

