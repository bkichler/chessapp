class Pawn < Piece
  def valid_move?(x_new, y_new)
    return true if capture_move?(x_new, y_new)
    return false if !within_bounds?(x_new, y_new)
    return false if backwards_move?(x_new)
    return false if vertical_blocker?(x_new, y_new)
    return false if horizontal_move?(y_new)
    okay_length?(x_new)
  end
  
  def backwards_move?(x_new)
    # check if piece is white; if so, then return if 
    # y_new is lower than current; else return if y is 
    # higher than current
    color ? x_new < x_pos : x_new > x_pos
  end
  
  # still need to add capture move logic

  def capture_move?(x_new, y_new)
    target = game.pieces.where("x_pos = ? AND y_pos = ?", x_new, y_new).first
    !target.nil?
    if move_type(x_new, y_new) == :diagonal && x_diff(x_new) == 1 && y_diff(y_new) == 1
      target.color != self.color && target.type != "King"
    end
  end
  
  def first_move?(y_new)
    # checks if first move by checking if piece is white
    # or not and then checking if it's in its original row
    (color && y_pos == 1) || (!color && y_pos == 6)
  end
  
  def okay_length?(x_new)
    x_diff = x_diff(x_new)
    # if it's first move, distance can be 1 or 2; else distance is 1
    first_move?(x_new) ? (x_diff == 1 || x_diff == 2) : x_diff == 1
  end
    
  def horizontal_move?(y_new)
    # check if x-position is changing
    y_diff = y_diff(y_new)
    y_diff != 0
  end

  def vertical_blocker?(x_new, y_new)
    blocker = game.pieces.where("x_pos = ? AND y_pos = ?", x_new, y_new).first
    !blocker.nil?
  end

  def symbol
    self.color ? '♙' : '♟'
  end
end