class Queen < Piece
  def valid_move?(x_new, y_new)
<<<<<<< HEAD
    return false if !within_bounds?(x_new, y_new)
    (x_pos == x_new || y_pos == y_new || x_diff(x_new) == y_diff(y_new))
  end
  
  #will eventually add capture move logic
  def capture_move?(x_new, y_new)
=======
    return false if is_obstructed?(x_new, y_new) == false
    (x_pos == x_new || y_pos == y_new || x_diff(x_new) == y_diff(y_new))
>>>>>>> 1be4616e7397b9a2216b243dce305225ef34f3c8
  end
end