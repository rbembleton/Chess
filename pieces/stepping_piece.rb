class SteppingPiece < Piece

  def moves
    possible_moves = []
    x, y = @position
    deltas.each do |dx, dy|
      possible_moves << [dx + x, dy + y] unless obstruction?(dx + x, dy + y)
    end
    possible_moves
  end
end
