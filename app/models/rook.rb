class Rook < Piece
  def valid_move?(x_new, y_new)
    rook_move = move_type(x_new, y_new)
    if rook_move == :vertical || rook_move == :horizontal
      !is_obstructed?(x_new, y_new) && within_bounds?(x_new, y_new)
    else 
      return false
    end
  end

  def symbol
    self.color ? '♖' : '♜'
  end
end