class Queen < Piece
  def valid_move?(x_new, y_new)
    return true if capture_move?(x_new, y_new)
    return false if is_obstructed?(x_new, y_new)
    (x_pos == x_new || y_pos == y_new || x_diff(x_new) == y_diff(y_new))
  end
  
  def capture_move?(x_new, y_new)
  end
end