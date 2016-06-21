class Pawn < Piece

  def initialize(pos, board, color)
    super(pos, board, color)
    @icon = "♟"
    @move_dir = color == :black ? 1 : -1
  end

  def move
    x, y = @position
    regular_move = [delta_move[0] + x, delta_move[1] + y]
    @possible_moves << regular_move unless obstruction?(regular_move)


  end

  def delta_move
    [[@move_dir, 0]]
  end

  def delta_attack
    [ [@move_dir, -1], [@move_dir, 1] ]
  end



end
