class Knight < Piece
  def valid_move?(x_new, y_new)
    return false if move_type(x_new, y_new) == :invalid
    return false if !(game.piece_present(x_new, y_new).nil?) && game.piece_present(x_new, y_new).color == self.color
    # pulls the absolute value of the distance of the 
    # new space from the user's selected space
    x_diff = x_diff(x_new).abs
    y_diff = y_diff(y_new).abs

    if x_diff == 1 && y_diff == 2 || y_diff == 1 && x_diff == 2
      return true
    else 
      false
    end
  end

  def symbol
    self.color ? '♘' : '♞'
  end
end