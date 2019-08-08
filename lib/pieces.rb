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
    all_pieces = Array.new
    board.white_pieces.each { |piece| all_pieces << piece }
    board.black_pieces.each { |piece| all_pieces << piece }
    check_for_pieces(all_pieces, board, x, y)
  end

  def check_for_pieces(pieces, board, x, y)
      (1..8).each do |i|
        break unless up(x+i, y, board)
      end

      (1..8).each do |i|
        break unless up(x-i, y, board)
      end

      (1..8).each do |i|
        break unless up(x, y+i, board)
      end

      (1..8).each do |i|
        break unless up(x, y-i, board)
      end
    end
  end

  def up(x, y, board)
    unless out_of_bounds(x, y)
      piece = board.update[x][y]
      if "OO" == piece
        @moves << [x, y]
      else 
        (@moves << [x, y]) if @colour != piece.colour
        return false
      end
    end
  end

  def out_of_bounds(x, y)
    (x > 7 or x < 0 or y > 7 or x < 0)
  end
 
class Knight
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "k"
  end
end
 
class Bishop
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "b"
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