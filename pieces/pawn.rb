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



end
