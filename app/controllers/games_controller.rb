class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join_as_black, :join_as_white, :move]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
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
    # May need to remove one of these methods - BK
    @game.populate_game!
    @game.set_player_ids
    redirect_to game_path(@game.id)
  end

  def join_as_white
    @game = Game.find(params[:id])
    return render_not_found if @game.nil?
    @game.update_attribute(:white_player_user_id, current_user.id)
    # May need to remove one of these methods - BK
    @game.populate_game!
    @game.set_player_ids
    redirect_to game_path(@game.id)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

<<<<<<< HEAD
  def move
    @game = Game.find(params[:id])
    @piece = Piece.where(game_id: params[:id], x_pos: params[:start_x], y_pos: params[:start_y]).first
    #@piece = @game.pieces.where(x_pos: params[:start_x], y_pos: params[:start_y]) # find the piece to move
    @piece.move_to!(params[:end_x].to_i, params[:end_y].to_i) 
    #@piece.update(x_pos: params[:end_x], y_pos: params[:end_y])                   # update the piece's position to the new position
    redirect_to game_path(@game.id)                                              # refresh the page ot show new position
  end
=======
  # def move
  #   @game = Game.find(params[:id])
  #   @piece = Piece.where(game_id: params[:id], x_pos: params[:start_x], y_pos: params[:start_y]).first
  #   #@piece = @game.pieces.where(x_pos: params[:start_x], y_pos: params[:start_y]) # find the piece to move
  #   @piece.move_to!(params[:end_x].to_i, params[:end_y].to_i)
  #   #@piece.update(x_pos: params[:end_x], y_pos: params[:end_y])                   # update the piece's position to the new position
  #   redirect_to game_path(@game.id)                                              # refresh the page ot show new position
  # end
>>>>>>> origin/master

  private

  def game_params
    params.require(:game).permit(:black_player_user_id, :white_player_user_id, :turn_user_id, :game_id)
  end

  # def move_params
  #   params.require(:game).permit(:start_x, :start_y, :end_x, :end_y, :game_id)
  # end
end
