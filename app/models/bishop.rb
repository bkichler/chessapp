class Bishop < Piece
  def valid_move?(x_new, y_new)
    if move_type(x_new, y_new) == :diagonal
      !is_obstructed?(x_new, y_new) && within_bounds?(x_new, y_new)
    else 
      return false
    end
  end
end