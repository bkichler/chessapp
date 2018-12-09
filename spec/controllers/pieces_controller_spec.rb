require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#update' do
    it 'should allow x_pos and y_pos to be updated' do
      user1 = FactoryBot.create(:user)
      sign_in user1
      user2 = FactoryBot.create(:user)
      sign_in user2
      game = FactoryBot.create(:game)

      #Use game controller to join game
      @controller = GamesController.new
      put :join_as_white, params: { id: game.id, game: { white_player_user_id: user1.id } }
      put :join_as_black, params: { id: game.id, game: { black_player_user_id: user2.id } }
      game.reload

      # Switch to piece controller, send put request to update method
      @controller = PiecesController.new
      piece = game.pieces.where("x_pos = ? AND y_pos = ?", 7, 1).first 
      put :update, params: {game_id: game.id, id: piece.id, piece: { x_pos: 5, y_pos: 2 }}
      expect(response).to have_http_status :success
      piece.reload
      expect(piece.x_pos).to eq(5)
    end
  end

  describe 'pieces#move' do
    it 'should call move_to! method and update piece position' do
      user1 = FactoryBot.create(:user)
      sign_in user1
      user2 = FactoryBot.create(:user)
      sign_in user2
      game = FactoryBot.create(:game)

      #Use game controller to join game
      @controller = GamesController.new
      put :join_as_white, params: { id: game.id, game: { white_player_user_id: user1.id } }
      put :join_as_black, params: { id: game.id, game: { black_player_user_id: user2.id } }
      game.reload

      # Switch to piece controller, send put request to move method
      @controller = PiecesController.new
      piece = game.pieces.where("x_pos = ? AND y_pos = ?", 6, 4).first
      put :move, params: { 
                            game_id: game.id,
                            id: piece.id,
                            piece: { 
                                      end_x: 5,
                                      end_y: 4
                                    }
                            }
      piece.reload
      expect(piece.x_pos).to eq(5)
    end
  end 
end
