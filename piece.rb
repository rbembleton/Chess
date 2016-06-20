class Piece
  attr_reader :position, :board, :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
    #to be deteremiend
  end

end
