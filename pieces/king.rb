class King < SteppingPiece

  def initialize(pos, board, color)
    super(pos, board, color)
    @icon = "♚"
  end

  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1],
    [ 0, -1],
    [ 0,  1]
  ]

  def deltas
    DELTAS
  end

  def valid_moves
    temp_valid_moves = []
    possible_moves.each do |move|
      @board.move!(self.position, move)
      old_pos = self.position # just for king
      self.position = move
      temp_valid_moves << move unless @board.in_check?(self.color)
      @board.undo_last_move
      self.position = old_pos # just for king
    end
    temp_valid_moves
  end

end
