class Queen < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
    @icon = {:white => "♕", :black =>"♛"}
  end

  def move_dirs
    [[-1, 0],[1, 0],[0, -1],[0, 1],[-1, -1],[-1, 1],[1, -1],[1, 1]]
  end



end
