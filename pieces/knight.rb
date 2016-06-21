class Knight < SteppingPiece

  def initialize(position, board, color)
    super(position, board, color)
    @icon = "♞"
  end

  DELTAS = [
    [-2, -1],
    [-1, -2],
    [-2,  1],
    [ 1, -2],
    [-1,  2],
    [ 2, -1],
    [ 2,  1],
    [ 1,  2]
  ]

  def deltas
    DELTAS
  end



end
