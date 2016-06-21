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

end
