class Piece
  attr_accessor :position
  attr_reader :board, :color, :icon

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def possible_moves
    raise "moves must be implemented in the child class"
  end

  def valid_moves
    temp_valid_moves = []
    possible_moves.each do |move|
      @board.move!(self.position, move)
      temp_valid_moves << move #unless @board.in_check?(self.color)
      @board.undo_last_move
    end
    temp_valid_moves
  end

  def same_color?(other_piece)
    return nil unless other_piece
    self.color == other_piece.color
  end

  def other_color?(other_piece)
    return nil unless other_piece
    self.color != other_piece.color
  end

  def obstruction?(pos) # there is a different method for Pawns
    x, y = pos
    return false if @board[pos].nil?
    return true if self.same_color?(@board[pos])
  end

  def out_of_bounds?(pos)
    x, y = pos
    x < 0 || x > 7 || y < 0 || y > 7
  end

end
