class Pawn < Piece
  def valid_move?(x_new, y_new)
    true
  end

  def symbol
    self.color ? '♙' : '♟'
  end
end