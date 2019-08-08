class Pawn
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "p"
  end
 
  def possible_moves
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new
    self.colour == "white" ? (@moves << [x-1, y]) : (@moves << [x+1, y])
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
 
  def initialize(colour)
    @colour = colour
    @symbol = @colour[0] + "r"
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