require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#update action' do
    it 'should allow users to join games that have open seats' do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      patch :update, params: { id: game.id, game: { black_player_user_id: user.id } }
      expect(response).to redirect_to game_path(game.id)
      expect(game.black_player_user_id).to eq user.id
    end
  end
end
