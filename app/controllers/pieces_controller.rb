class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_filter :set_cache_headers
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

  def set_game!
    @game = Game.find(params[:game_id])
  end

  def piece_params
    params.require(:piece).permit(:game_id, :user_id, :type, :color, :x_pos, :y_pos, :x_new, :y_new)
  end

  # def set_cache_headers
  #   response.headers["Cache-Control"] = "no-cache, no-store"
  #   response.headers["Pragma"] = "no-cache"
  #   response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  # end
end

