class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_game!

  def index
    render json: @game.pieces
  end
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @piece = @game.pieces.find(params[:id])
    render json: @piece
  end

  def update
    @piece = @game.pieces.find(params[:id])
    @piece.update_attributes(piece_params)
    render json: @piece
  end

  def move
    @piece = @game.pieces.find(params[:id])
    if @piece.valid_move?(params[:x_new].to_i, params[:y_new].to_i)
      @piece.move_to!(params[:x_new], params[:y_new])
      render json: @piece
    else
      @piece.move_to!(params[:x_new], params[:y_new])
      render json: { status: "invalid" }
    end
  end

  private

  def set_game!
    @game = Game.find(params[:game_id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos, :x_new, :y_new)
  end
end

