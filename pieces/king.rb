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
  
end
