class Game
  attr_accessor :board
 
  def initialize
    @board = Board.new
  end
 
  def play_round
    while true
      puts "Select piece xy"
      fromXY = gets.chomp
      piece = get_piece(fromXY)
      piece.current_location = get_xy(fromXY)
      if piece == "O"
        puts "No chess piece"
        next
      else
        break
      end
    end
 
    while true
      puts "Move to xy"
      toXY = get_xy(gets.chomp)
      piece.possible_moves
      pawn_check_enemies(piece) if piece.symbol == "p"
      if piece.moves.include?(toXY)
        move_piece(piece, toXY)
        break
      else
        next
      end
    end
  end
 
  private
  def move_piece(piece, toXY)
    @board.update[toXY[0]][toXY[1]] = piece
    xy = piece.current_location
    piece.current_location = [toXY[0], toXY[1]]
    @board.update[xy[0]][xy[1]] = "O"
  end

  def get_piece(coordinates) 
    xy = get_xy(coordinates)
    @board.update[xy[0]][xy[1]]
  end
 
  def get_xy(coordinates)
    coordinates = coordinates.to_s
    coordinates = coordinates.split("")
    x = coordinates[0].to_i
    y = coordinates[1].to_i
    [x, y]
  end
 
  def pawn_check_enemies(piece)
    x = piece.current_location[0]
    y = piece.current_location[1]
    puts [x-1, y+1].inspect
    if piece.colour == "white"
      (piece.moves << [x-1, y+1]) if @board.black_pieces.include?(@board.update[x-1][y+1])
      (piece.moves << [x-1, y-1]) if @board.black_pieces.include?(@board.update[x-1][y-1])
      return
    else
      (piece.moves << [x-1, y+1]) if @board.white_pieces.include?(@board.update[x-1][y+1])
      (piece.moves << [x-1, y-1]) if @board.white_pieces.include?(@board.update[x-1][y-1])
      return
    end
  end
end
 
class Board
  attr_reader :white_pieces, :black_pieces

  def initialize
    create_board
    populate_board
  end
 
  def create_board
    @board = Array.new
    @row = Array.new
    8.times do
      8.times do
        @row << "O"
      end
      @board << @row
      @row = Array.new
    end
  end
 
  def show
    display_row = Array.new
    for row in @board
      for cell in row
         cell != "O" ? (display_row << cell.symbol) : (display_row << cell)
      end
      puts display_row.join("-")
      display_row = Array.new
    end
  end
 
  def update
    @board
  end
 
  private
  def populate_board
    #populate black pieces
    @black_pieces = Array.new
    8.times do |y|
      @board[1][y] = Pawn.new("black")
      @black_pieces << @board[1][y]
    end
 
    @board[5][1] = Rook.new("black")
    @black_pieces << @board[5][1]
    @board[0][1] = Knight.new("black")
    @board[0][2] = Bishop.new("black")
    @board[0][3] = Queen.new("black")
    @board[0][4] = King.new("black")
    @board[0][5] = Bishop.new("black")
    @board[0][6] = Knight.new("black")
    @board[0][7] = Rook.new("black")
    #@board[0].each { |piece| @black_pieces << piece }
 
    #populate white pieces
    @white_pieces = Array.new
    8.times do |y|
      @board[6][y] = Pawn.new("white")
      @white_pieces << @board[6][y]
    end
 
    @board[7][0] = Rook.new("white")
    @board[7][1] = Knight.new("white")
    @board[7][2] = Bishop.new("white")
    @board[7][3] = Queen.new("white")
    @board[7][4] = King.new("white")
    @board[7][5] = Bishop.new("white")
    @board[7][6] = Knight.new("white")
    @board[7][7] = Rook.new("white")
    @board[7].each { |piece| @white_pieces << piece }
  end
end
 
class Pawn
  attr_reader :symbol, :colour
  attr_accessor :moves, :current_location
 
  def initialize(colour)
    @symbol = "p"
    @colour = colour
  end
 
  def possible_moves
    x = @current_location[0]
    y = @current_location[1]
    @moves = Array.new
    @moves << [x-1, y]
    @moves
  end
end
 
class Rook
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @colour = colour
    @symbol = "r" + @colour[0]
  end
end
 
class Knight
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @symbol = "k"
    @colour = colour
  end
end
 
class Bishop
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @symbol = "b"
    @colour = colour
  end
end
 
class Queen
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @symbol = "q"
    @colour = colour
  end
end
 
class King
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @symbol = "k"
    @colour = colour
  end
end