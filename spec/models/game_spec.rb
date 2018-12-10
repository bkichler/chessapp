require 'rails_helper'

RSpec.describe Game, type: :model do
  
  describe 'if king is in check' do
    it 'should return true if king is in check' do
     ## white = FactoryBot.create(:piece, color: true)
     ## black = FactoryBot.create(:piece, color: false)
     game = FactoryBot.create(:game)

     white = FactoryBot.create(:piece, color: true, x_pos: 0, y_pos: 4, type: 'King', game: game)
     black = FactoryBot.create(:piece, color: false, x_pos: 2, y_pos: 4, type: 'Rook', game: game)
      expect(game.check?(white)).to eq(true)
    end
  end
end