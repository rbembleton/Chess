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

    delta_attack.each do |dx, dy|
      @possible_moves << [dx + x, dy + y] if check_for_opponent?([dx + x, dy + y])
    end
  end

  def delta_move
    [[@move_dir, 0]]
  end

  def delta_attack
    [ [@move_dir, -1], [@move_dir, 1] ]
  end

  def check_for_opponent(x, y)
    unless @board[[x, y]].nil?
      return self.other_color?(@board[[x, y]])
    end
    false
  end



end
