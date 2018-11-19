require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#update action' do
    it 'should allow users to update game params' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      patch :update, params: { id: game.id, game: { black_player_user_id: user.id } }
      expect(response).to redirect_to game_path(game.id)
      game.reload
      expect(game.black_player_user_id).to eq user.id
    end
  end

  describe 'games#join_as_white action' do
    it 'should allow users to join a game as the white player' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      put :join_as_white, params: { id: game.id, game: { white_player_user_id: user.id } }
      expect(response).to redirect_to game_path(game.id)
      game.reload
      expect(game.white_player_user_id).to eq user.id
    end
  end

  describe 'games#join_as_black action' do
    it 'should allow users to join a game as the black player' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      put :join_as_black, params: { id: game.id, game: { black_player_user_id: user.id } }
      expect(response).to redirect_to game_path(game.id)
      game.reload
      expect(game.black_player_user_id).to eq user.id
    end
  end

  describe "games#create action" do
    it "should successfully create a game" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { game: { white_player_user_id: user.id } }
      game = Game.last
      expect(response).to redirect_to game_path(game.id)
    end
  end

end

