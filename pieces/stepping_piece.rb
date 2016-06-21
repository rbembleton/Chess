class SteppingPiece < Piece

  def move
    x, y = @position
    deltas.each do |dx, dy|
      @possible_moves << [dx + x, dy + y] unless obstruction?(dx + x, dy + y)
    end
  end
end
