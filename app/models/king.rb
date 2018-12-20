class King < Piece
  def valid_move?(x_new, y_new)
    king_move = move_type(x_new, y_new)
    return false if king_move == :invalid || king_move == :knight
    return false if is_obstructed?(x_new, y_new)
    return false if !within_bounds?(x_new, y_new)

    # pulls the distance of the new space from
    # the user's selected space
    x_diff = x_diff(x_new).abs
    y_diff = y_diff(y_new).abs
    # returns true if move is only one space to
    # left / right / up / down / diagonal, as king can move
    if x_diff <= 1 && y_diff <= 1
      return true
    end
    # if it's not a legal king move, returns false
    false
  end

  def valid_move_castle?(x_new, y_new)
    puts "valid_move_castle? METHOD x_new: #{x_new} y_new: #{y_new}"
    king_move = move_type(x_new, y_new)
    puts"THIS IS BEFORE: IS THE KING OBSTRUCTED? MOVE TYPE"
    return false if king_move == :invalid || king_move == :knight
    if king_move == :horizontal
      puts"IS THE KING OBSTRUCTED? x_new: #{x_new}"
      !is_obstructed?(x_new, y_new) && within_bounds?(x_new, y_new)
      puts"IS THE KING OBSTRUCTED? NEXT STEP!!!"
    else 
      return false
    end

    puts "WE ARE NOT OBSTRUCTED!"
    # pulls the distance of the new space from
    # the user's selected space
    x_diff = x_diff(x_new).abs
    y_diff = y_diff(y_new).abs
    # returns true if move can castle
    if x_diff == 2 && y_diff == 0
      return true
    end
    # if it's not a legal castle king move, returns false
    false
  end

  def symbol
    self.color ? '♔' : '♚'
  end

  def can_castle?(x_new) #x_new is kings new position
    #King side or Queen side
    if x_new > x_pos
      rook = rook_side('Queen')
    else
      rook = rook_side('King')
    end

    # king should be unmoved, move exactly 2 spaces, and only in x direction
    return false unless (self.state == 'unmoved') && (rook.present?) && (rook.state == 'unmoved')
    return false unless x_diff(x_new) == 2
    return self.valid_move_castle?(x_new, self.y_pos)

  end

  def rook_side(side)
    if side == 'King'
      return game.pieces.find_by(type: 'Rook', x_pos: 0, y_pos: y_pos)
    elsif side == 'Queen'
      return game.pieces.find_by(type: 'Rook', x_pos: 7, y_pos: y_pos)
    else
      return nil
    end
  end

  def castle!(x_new) #x_new is kings new position
    if x_new > x_pos
      rook = rook_side('Queen')
      rook_x = x_new - 1
    else
      rook = rook_side('King')
      rook_x = x_new + 1
    end

    rook.update_attributes!(x_pos: rook_x)
    self.update_attributes!(x_pos: x_new)   
  end

  def in_check?
    # king = pieces.find_by(type: 'King', user_id: current_user.id)
    king = self
    x_king = king.x_pos
    y_king = king.y_pos
 
    if !user_id
      self.game.pieces.each do |piece|
        if piece.valid_move?(x_king, y_king)
          return true
        end
      end
    end 
    return false
  end
end
