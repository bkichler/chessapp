require 'rails_helper'

RSpec.describe Knight, type: :model do
  it 'is created with populate_game method' do
    game = FactoryBot.create(:game)
    expect(game.pieces.where(type: "Knight").size).to be(4)
  end

  it 'has a valid_move? method that returns true for a 2-to-1 move in any direction' do
    game = FactoryBot.create(:game)
    user = FactoryBot.create(:user)
    game.black_player_user_id = user.id
    game.populate_game!
    knight = game.pieces.where("x_pos = ? AND y_pos = ?", 1, 7).first
    expect(knight.valid_move?(2, 5)).to eq(true)
    expect(knight.valid_move?(0, 5)).to eq(true)
    expect(knight.valid_move?(6, 3)).to eq(false)
    expect(knight.valid_move?(6, 4)).to eq(false)
    expect(knight.valid_move?(5, 3)).to eq(false)
  end
  
  it 'should be able to move 2-1 to around the board using move_to!' do
    Game.destroy_all
    User.destroy_all
    Piece.destroy_all
    game = FactoryBot.create(:game)
    user = FactoryBot.create(:user)
    game.black_player_user_id = user.id
    game.populate_game!
    Knight.first.move_to!(5, 2)
    Knight.first.move_to!(4, 4)
    expect(game.pieces.where("x_pos = ? AND y_pos = ?", 4, 4).first.id).to eq(Knight.first.id)
  end
end