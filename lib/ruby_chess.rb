require './lib/pieces.rb'
require './lib/board.rb'

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
      if piece == "OO"
        puts "No chess piece"
        next
      else
        break
      end
    end
 
    while true
      puts "Move to xy"
      toXY = get_xy(gets.chomp)
      piece.possible_moves(@board)
      if piece.moves.include?(toXY)
        move_piece(piece, toXY)
        piece.possible_moves(@board)
        break
      else
        puts "Illegal Move"
        next
      end
    end
  end
 
  private
  def move_piece(piece, toXY)
    @board.update[toXY[0]][toXY[1]] = piece
    xy = piece.current_location
    piece.current_location = [toXY[0], toXY[1]]
    @board.update[xy[0]][xy[1]] = "OO"
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
end