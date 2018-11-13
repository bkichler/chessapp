class Pawn < Piece
  def valid_move?(x_new, y_new)
    return false if backwards_move?(x_new)
    return true if capture_move(x_new, y_new)
    return false if horizontal_move?(x_new)
    return false if is_obstructed?(x_new, y_new)
    okay_length(y_new)
  end
  
  def backwards_move?
    #check color. check if direction is forward based on that.
  end
  
  def capture_move(x_new, y_new)
  end
  
  def first_move?(y_new)
    # if player is on bottom of board, first move is if the pawn is in row 6
    # if player is on top of board, first move is if the pawn is in row 1
  end
  
  def okay_length?(y_new)
    y_diff = y_diff(y_new)
    first_move(y_new) ? (y_diff == 1 || y_diff == 2) : y_diff == 1
  end
    
  def horizontal_move?(x_new)
    # check if x-position is changing
    x_diff = x_diff(x_new)
    x_diff != 0
  end
end