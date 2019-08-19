module Moves  
  def cell(x, y, board, current_piece)
    unless out_of_bounds(x, y)
      piece = board.update[x][y]
      if "OO" == piece
        current_piece.moves << [x, y]
      else 
        (current_piece.moves << [x, y]) if @colour != piece.colour
        return false
      end
    end
  end

  def out_of_bounds(x, y)
    (x > 7 or x < 0 or y > 7 or x < 0)
  end
end

class Pawn
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "p"
  end
 
  def possible_moves(board)
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new
    self.colour == "white" ? (@moves << [x-1, y]) : (@moves << [x+1, y])
    check_enemies(board)
  end

  def check_enemies(board)
    x = self.current_location[0]
    y = self.current_location[1]
    if self.colour == "white"
      (self.moves << [x-1, y+1]) if board.black_pieces.include?(board.update[x-1][y+1])
      (self.moves << [x-1, y-1]) if board.black_pieces.include?(board.update[x-1][y-1])
      self.moves.delete([x-1, y]) if board.black_pieces.include?(board.update[x-1][y])
      return
    else
      (self.moves << [x+1, y-1]) if board.white_pieces.include?(board.update[x+1][y-1])
      (self.moves << [x+1, y+1]) if board.white_pieces.include?(board.update[x+1][y+1])
      self.moves.delete([x+1, y]) if board.white_pieces.include?(board.update[x+1][y])
      return
    end
  end
end
 
class Rook
  include Moves
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "r"
  end

  def possible_moves(board)
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new
    check_for_pieces(board, x, y)
  end

  def check_for_pieces(board, x, y)
    (1..7).each do |i|
      break unless cell(x+i, y, board, self)
    end

    (1..7).each do |i|
      break unless cell(x-i, y, board, self)
    end

    (1..7).each do |i|
      break unless cell(x, y+i, board, self)
    end

    (1..7).each do |i|
      break unless cell(x, y-i, board, self)
    end
  end
end
 
class Knight
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "k"
  end
end
 
class Bishop
  include Moves
  
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "b"
  end

  def possible_moves(board)
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new
    check_for_pieces(board, x, y)
  end

  def check_for_pieces(board, x, y)
    (1..7).each do |i|
      break unless cell(x+i, y+i, board, self)
    end

    (1..7).each do |i|
      break unless cell(x-i, y-i, board, self)
    end

    (1..7).each do |i|
      break unless cell(x+i, y-i, board, self)
    end

    (1..7).each do |i|
      break unless cell(x-i, y+i, board, self)
    end
  end
end
 
class Queen
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "q"
  end
end
 
class King
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "K"
  end
end