class Bishop < SlidingPiece

  def initialize(position, board, color)
    super(position, board, color)
    @icon = "♝"
    # @icon = {:white => "♗", :black =>"♝"}
  end

  def move_dirs
    [[-1, -1],[-1, 1],[1, -1],[1, 1]]
  end



end
