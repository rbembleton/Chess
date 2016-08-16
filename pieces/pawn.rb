class Pawn < Piece

  def initialize(pos, board, color)
    super(pos, board, color)
    @icon = "♟"
    @move_dir = color == :black ? 1 : -1
  end

  def possible_moves
    moves = []
    x, y = @position
    regular_move = [delta_move[0] + x, delta_move[1] + y]

    moves << regular_move unless obstruction?(regular_move)

    if (color == :white && x == 6) || (color == :black && x == 1)
      opening_move = [(delta_move[0] * 2) + x, (delta_move[1] * 2) + y]
      moves << opening_move unless obstruction?(regular_move)
    end

    delta_attack.each do |dx, dy|
      moves << [dx + x, dy + y] if check_for_opponent?([dx + x, dy + y])
    end
    moves
  end

  def delta_move
    [@move_dir, 0]
  end

  def delta_attack
    [ [@move_dir, -1], [@move_dir, 1] ]
  end

  def check_for_opponent?(pos)
    unless @board[pos].nil?
      return self.other_color?(@board[pos])
    end
    false
  end

  def obstruction?(pos) # for Pawn only, includes opposite color
    x, y = pos
    return false if @board[pos].nil?
    true
  end



end
