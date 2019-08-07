class Game
  attr_accessor :board
 
  def initialize
    @board = Board.new
  end
 
  def play_round
    while true
      puts "Select piece xy"
      piece = get_piece(gets.chomp)
      if piece == "O"
        puts "No chess piece"
        next
      else
        break
      end
    end
 
    while true
      puts "Move to xy"
      xy = get_xy(gets.chomp)
      x = xy[0]
      y = xy[1]
      pawn_check_enemies(xy, piece) if piece.symbol = "p"
      piece.possible_moves(x, y)
      if piece.moves.include?(xy)
        @board.update[x][y] = piece
      end
    end
  end
 
  private
  def get_piece(coordinates)
    xy = get_xy(coordinates)
    @board.update[xy[0]][xy[1]]
  end
 
  def get_xy(coordinates)
    coordinates = coordinates.to_s
    coordinates = coordinates.split
    x = coordinates[0].to_i
    y = coordinates[1].to_i
    [x, y]
  end
 
  def pawn_check_enemies(coordinates, piece)
    xy = get_xy(coordinates)
    x = xy[0]
    y = xy[1]
    if piece.colour == "black"
      for black_piece in black_pieces
        add_moves(x, y, piece, black_piece)
      end
    else
      for white_piece in white_pieces
        add_moves(x, y, piece, white_piece)
      end
    end
  end
 
  def add_moves(x, y, piece, enemy_piece)
    piece.moves << [x+1, y+1] if @board.update[x+1][y+1] == enemy_piece
    piece.moves << [x-1, y+1] if @board.update[x+1][y+1] == enemy_piece
  end
end
 
class Board
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
 
  def update(position)
    @board
  end
 
  private
  def populate_board
    #populate black pieces
    black_pieces = Array.new
    8.times do |y|
      @board[1][y] = Pawn.new("black")
      black_pieces << @board[1][y]
    end
 
    @board[0][0] = Rook.new("black")
    @board[0][1] = Knight.new("black")
    @board[0][2] = Bishop.new("black")
    @board[0][3] = Queen.new("black")
    @board[0][4] = King.new("black")
    @board[0][5] = Bishop.new("black")
    @board[0][6] = Knight.new("black")
    @board[0][7] = Rook.new("black")
    @board[0].each { |piece| black_pieces << piece }
 
    #populate white pieces
    white_pieces = Array.new
    8.times do |y|
      @board[6][y] = Pawn.new("white")
      white_pieces << @board[6][y]
    end
 
    @board[7][0] = Rook.new("white")
    @board[7][1] = Knight.new("white")
    @board[7][2] = Bishop.new("white")
    @board[7][3] = Queen.new("white")
    @board[7][4] = King.new("white")
    @board[7][5] = Bishop.new("white")
    @board[7][6] = Knight.new("white")
    @board[7][7] = Rook.new("white")
    @board[7].each { |piece| white_pieces << piece }
  end
end
 
class Pawn
  attr_reader :symbol, :colour
  attr_accessor :moves
 
  def initialize(colour)
    @symbol = "p"
    @colour = colour
  end
 
  def possible_moves(x, y)
    @moves = Array.new
    @moves << [x, y+1]
    @moves
  end
end
 
class Rook
  attr_reader :symbol, :colour
 
  def initialize(colour)
    @symbol = "r"
    @colour = colour
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

#game = Game.new
#game.board.show