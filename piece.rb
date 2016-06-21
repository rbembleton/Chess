class Piece
  attr_reader :position, :board, :color, :icon, :possible_moves

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
    @possible_moves = []
  end

  def moves
    #to be deteremiend
  end

  def same_color?(other_piece)
    return nil unless other_piece
    self.color == other_piece.color
  end

  def other_color?(other_piece)
    return nil unless other_piece
    self.color != other_piece.color
  end

  def obstruction?(x, y)
    return false unless x.between?(0,7) && y.between?(0,7)
    return false if @board[x, y].nil?
    return true if self.same_color?(@board[x, y])
  end

  def reset_possible_moves
    @possible_moves = []
    moves
  end

end
