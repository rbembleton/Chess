class SteppingPiece < Piece # King, Knight

  def possible_moves
    moves = []
    x, y = @position
    deltas.each do |dx, dy|
      moves << [dx + x, dy + y] unless out_of_bounds?([dx + x, dy + y]) || obstruction?([dx + x, dy + y])
    end
    moves
  end
end
