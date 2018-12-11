class Piece < ApplicationRecord
  after_initialize :starting_state

  belongs_to :game, optional: true
  belongs_to :user, optional: true
  has_many :moves

  def within_bounds?(x_new, y_new)
    x_new >= 0 && y_new >= 0 && x_new <= 7 && y_new <= 7
  end

  def valid_move?(x_new, y_new)
    x_new = x_new.to_i
    y_new = y_new.to_i
    return false if move_type(x_new, y_new) == :invalid
    true
  end

  # returns the distance between the input 
  # x position and the current x position
  # in order to check for valid move distance
  def x_diff(x)
    (x - x_pos).abs
  end
   
  # same as above but for y position
  def y_diff(y)
    (y - y_pos).abs
  end

  def move_type(x_new, y_new)
    # Need to deal with Knight case
    vertical_delta = (y_new - y_pos).abs
    horizontal_delta = (x_new - x_pos).abs
    return :horizontal if horizontal_delta > 0 && vertical_delta.zero?
    return :vertical if vertical_delta > 0 && horizontal_delta.zero?
    return :diagonal if vertical_delta == horizontal_delta
    # Knight case is a bit of a hack, tried the code below, could not quite get it to pass the test. This needs to be addressed 
    # at some point
    # return :knight if Rational(vertical_delta, horizontal_delta) == (2/1) || Rational(vertical_delta, horizontal_delta) == (1/2)
    return :knight if self.type = "Knight"
    return :invalid if vertical_delta > 0 && horizontal_delta > 0 && vertical_delta != horizontal_delta
  end

  def is_obstructed?(x_new, y_new)
    puts "IS OBSTRUCTED??"
    pieces_in_row = game.pieces.where(x_pos: x_new)
    pieces_in_column = game.pieces.where(y_pos: y_new)
    # horizontal case
    if move_type(x_new, y_new) == :horizontal
      puts "HELLO THERE, WE ARE IN THE HORIZONTAL MOVE DIRECTION"
      !pieces_in_column.where("x_pos > ? AND x_pos < ?", [self.x_pos, x_new].min, [self.x_pos, x_new].max).empty?
      puts "HELLO THERE, WE ARE IN THE HORIZONTAL MOVE DIRECTION PART 2"
    # vertical case
    elsif move_type(x_new, y_new) == :vertical
      !pieces_in_row.where("y_pos > ? AND y_pos < ?", [self.y_pos, y_new].min, [self.y_pos, y_new].max).empty?
    # diagonal case
    elsif move_type(x_new, y_new) == :diagonal
      diagonal_blocker?(x_new, y_new)
    else
      puts "HELLO WE ARE IN THE NEXT STEP OF OBSTRUCTED"
      raise "Invalid move" if move_type(x_new, y_new) == :invalid
    end
  end

  # move_to! method calls valid_move? and will update a piece instance's
  # position and/or capture by setting positions to null. Could update
  # this later to incorporate a piece status
  
  def move_to!(x_new, y_new)
    x_new = x_new.to_i
    y_new = y_new.to_i
    # Will raise error if move is invalid
    return raise "Invalid move for #{self.type} to #{x_new}, #{y_new}" if !valid_move?(x_new, y_new)
    occupant = game.piece_present(x_new, y_new)
    current_piece = game.pieces.where(x_pos: x_pos, y_pos: y_pos).first
    if occupant.nil? 
      current_piece.update_attributes(x_pos: x_new, y_pos: y_new)
    elsif occupant.color != current_piece.color
      current_piece.update_attributes(x_pos: x_new, y_pos: y_new)
      occupant.update_attributes(x_pos: nil, y_pos: nil)
    else return raise "Invalid move"
    end
  end

  def piece_color
    if self.color == false
      'black'
    elsif self.color == true
      'white'
    else self.color
    end
  end

  def symbol
    self.color ? 'X' : 'Y'
  end

  def starting_state
    self.state ||= 'unmoved'
  end

  def diagonal_blocker?(x, y, idx = 0)
    x_range = (self.x_pos..x).to_a.tap { |x| x.pop; x.shift }
    y_range = (self.y_pos..y).to_a.tap { |y| y.pop; y.shift }
    if !game.piece_present(x_range[idx], y_range[idx]) && idx != idx[-1]
      idx = idx + 1
      diagonal_blocker?(x, y, idx)
    elsif !game.piece_present(x_range[idx], y_range[idx]) && idx == idx[-1]
      false
    else return true
    end
  end
end
