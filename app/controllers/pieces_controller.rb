class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_game!

  def index
    render json: @game.pieces
  end
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def update
    @piece = @game.pieces.find(params[:id])
    @piece.update_attributes(piece_params)
    render json: @piece
  end

  def move

  end

  private

  def set_game!
    @game = Game.find(params[:game_id])
  end
    
  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos)
  end
end

