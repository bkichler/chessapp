class PiecesController < ApplicationController
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @game = Game.find(params[:id])
    @piece = @game.pieces
  end

 def update
  @piece = Piece.find(params[:id])
  @piece.update_attributes(piece_params)
 end

  private

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_pos, :y_pos)
  end
end

##redirect_to games_url(game_id, selected_piece_id: params[:id]) 