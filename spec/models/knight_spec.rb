require 'rails_helper'

RSpec.describe Knight, type: :model do
  it 'is created with populate_game method' do
    game = FactoryBot.create(:game)
    expect(game.pieces.where(type: "Knight").size).to be(4)
  end

  it 'has a valid_move? method that returns true for a 2-to-1 move in any direction' do
    game = FactoryBot.create(:game)
    knight = FactoryBot.create(:knight)
    knight.game_id = game.id
    expect(knight.valid_move?(5, 2)).to eq(true)
    expect(knight.valid_move?(7, 2)).to eq(true)
    expect(knight.valid_move?(6, 3)).to eq(false)
    expect(knight.valid_move?(6, 4)).to eq(false)
    expect(knight.valid_move?(5, 3)).to eq(false)
  end
  
  it 'should be able to move 2-1 to around the board using move_to!' do
    game = FactoryBot.create(:game)
    knight = FactoryBot.create(:knight)
    knight.game_id = game.id
    knight.move_to!(5, 2)
    knight.reload
    knight.move_to!(4, 4)
    knight.reload
    expect(game.pieces.where("x_pos = ? AND y_pos = ?", 4, 4).first.id).to eq(knight.id)
  end
end