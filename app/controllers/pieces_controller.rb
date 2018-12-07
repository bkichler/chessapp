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
    @piece = @game.pieces.where(game_id: params[:game_id], x_pos: params[:start_x], y_pos: params[:start_y]).first
    @piece.move_to!(params[:end_x].to_i, params[:end_y].to_i)
    @piece.update_attributes(piece_params)
    render json: @piece
  end

  private

  def set_game!
    @game = Game.find(params[:game_id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos)
  end

  def move_params
    params.require(:piece).permit(:start_x, :start_y, :end_x, :end_y, :game_id)
  end
end

