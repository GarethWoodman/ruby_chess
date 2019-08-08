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
        @row << "OO"
      end
      @board << @row
      @row = Array.new
    end
  end
 
  def show
    display_row = Array.new
    for row in @board
      for cell in row
         cell != "OO" ? (display_row << cell.symbol) : (display_row << cell)
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
 
    @board[0][0] = Rook.new("black")
    @board[0][1] = Knight.new("black")
    @board[0][2] = Bishop.new("black")
    @board[0][3] = Queen.new("black")
    @board[0][4] = King.new("black")
    @board[0][5] = Bishop.new("black")
    @board[0][6] = Knight.new("black")
    @board[0][7] = Rook.new("black")
    @board[0].each { |piece| @black_pieces << piece }
 
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