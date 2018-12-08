class PiecesController < ApplicationController
  
  def index
    render json: Piece.order(:id)
  end  
  
  def create
    @pieces = current_game.pieces.create(piece_params)
  end

  def show
    @game = Game.find(params[:game_id])
    @piece = @game.pieces
  end

  def update
    piece = Piece.find(params[:game_id])
    piece.update_attributes(piece_params)
    render json: piece
  end

  def ks_castle
    @game = Game.find(params[:game_id])
    # Piece.where(game_id: @game.id, user_id: current_user.id) #how to get all pieces for current user
    # Piece.where(game_id: @game.id, user_id: current_user.id, type: 'King').first # how to get the king piece
    kings = King.where(game_id: @game.id, user_id: current_user.id) #better way to get the king
    rooks = Rook.where(game_id: @game.id, user_id: current_user.id, x_pos: 0)
    
    king = kings[0]
    rook = rooks[0]

    if king == nil || rook == nil
      render json: {}, status: 500
      return
    end

    x_new = 1

    if king.can_castle?(x_new)
      king.castle!(x_new)
      render json: {}, status: 200
      return
    else
      # can not perform castle
      render json: {}, status: 500
      return
    end
  end  

  def qs_castle
    @game = Game.find(params[:game_id])
    kings = King.where(game_id: @game.id, user_id: current_user.id) #better way to get the king
    rooks = Rook.where(game_id: @game.id, user_id: current_user.id, x_pos: 7)
    
    king = kings[0]
    rook = rooks[0]

    if king == nil || rook == nil
      render json: {}, status: 500
      return
    end

    x_new = 5

    if king.can_castle?(x_new)
      king.castle!(x_new)
      render json: {}, status: 200
      return
    else
      # can not perform castle
      render json: {}, status: 500
      return
    end
  end   

  private

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos, :state)
  end
end

