class Pawn < Piece
  def valid_move?(x_new, y_new)
    return false if !within_bounds?(x_new, y_new)
    return false if backwards_move?(y_new)
    # once capture move logic is complete, will add return true if capture_move(x_new, y_new)
    return false if horizontal_move?(x_new)
    # return false if is_obstructed?(x_new, y_new)
    okay_length?(y_new)
  end
  
  def backwards_move?(y_new)
    # check if piece is white; if so, then return if 
    # y_new is lower than current; else return if y is 
    # higher than current
    color ? y_new < y_pos : y_new > y_pos
  end
  
  # still need to add capture move logic

  def capture_move(x_new, y_new)
  end
  
  def first_move?(y_new)
    # checks if first move by checking if piece is white
    # or not and then checking if it's in its original row
    (color && y_pos == 1) || (!color && y_pos == 6)
  end
  
  def okay_length?(y_new)
    y_diff = y_diff(y_new)
    # if it's first move, distance can be 1 or 2; else distance is 1
    first_move?(y_new) ? (y_diff == 1 || y_diff == 2) : y_diff == 1
  end
    
  def horizontal_move?(x_new)
    # check if x-position is changing
    x_diff = x_diff(x_new)
    x_diff != 0
  end
end