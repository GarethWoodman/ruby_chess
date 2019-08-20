require './lib/ruby_chess'

RSpec.describe Game do
  game = Game.new

  describe "Piece Positions" do
    it "[7][0] is a rook" do
      rook = game.board.update[7][0]
      expect(rook.is_a?(Rook)).to eql (true)
    end

    it "is in check?" do
      puts
      board = game.board
      8.times do |x|
        8.times do |y|
          board.update[x][y] = "□"
        end
      end
      puts "put the king in check"
      board.update[7][0] = Rook.new("white")
      board.update[0][1] = King.new("black")
      king = board.update[0][1]
      board.show
      game.play_round
      board.show
      expect(king.in_check).to eql ("check")
    end

    it "is check mate?" do
      puts
      board = game.board
      8.times do |x|
        8.times do |y|
          board.update[x][y] = "□"
        end
      end
      puts "put the king in check mate"
      board.update[3][4] = Knight.new("white")
      board.update[0][1] = King.new("black")

      board.update[0][2] = Pawn.new("black")
      board.update[0][0] = Pawn.new("black")
      board.update[1][2] = Pawn.new("black")
      board.update[1][0] = Pawn.new("black")
      board.update[1][1] = Pawn.new("black")

      king = board.update[0][1]
      board.show
      game.play_round
      board.show
      expect(king.in_check).to eql ("check mate")
    end
  end
end