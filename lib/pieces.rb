module Moves
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location

  def cell(x, y, board, current_piece)
    unless out_of_bounds(x, y)
      piece = board.update[x][y]
      if "□" == piece
        current_piece.moves << [x, y]
      else 
        if @colour != piece.colour
          if piece.is_a?(King)
            puts "check"
            piece.current_location = [x, y]
            piece.possible_moves(board)
            puts "check mate" if piece.moves.length == 0
          end
          (current_piece.moves << [x, y]) 
        end
        return false
      end
    end
  end

  def out_of_bounds(x, y)
    (x > 7 or x < 0 or y > 7 or x < 0)
  end
end

class Pawn
  include Moves
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♙" : @symbol = "♟"
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
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♖" : @symbol = "♜"
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
  include Moves
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♘" : @symbol = "♞"
  end

  def possible_moves(board)
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new

    dx = [2, 2, -2, -2, 1, 1, -1, -1] 
    dy = [1, -1, 1, -1, 2, -2, 2, -2] 

    8.times do |i|
      cell(dx[i]+x, dy[i]+y, board, self) 
    end
  end
end
 
class Bishop
  include Moves
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♗" : @symbol = "♝"
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
  include Moves
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♕" : @symbol = "♛"
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
 
class King
  include Moves
 
  def initialize(colour)
    @colour = colour
    @colour == "white" ? @symbol = "♔" : @symbol = "♚"
  end

  def possible_moves(board)
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new

    dx = [1, 1, 1, -1, -1, -1, 0, 0] 
    dy = [1, 0, -1, 0, 1, -1, 1, -1] 

    8.times do |i|
      cell(dx[i]+x, dy[i]+y, board, self) 
    end
  end
end