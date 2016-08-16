class SlidingPiece < Piece #Bishop, Rook, Queen

  def move_dirs

  end

  def possible_moves
    moves = []
    move_dirs.each do |dx, dy|
      moves += find_move(dx, dy)
    end
    moves
  end

  def find_move(dx, dy)
    x, y = @position
    temp_moves = []
    until out_of_bounds?([(x + dx), (y + dy)]) || obstruction?([(x + dx), (y + dy)])
      x += dx
      y += dy
      temp_moves << [x, y]
      break if self.other_color?(@board[[x, y]])
    end
    temp_moves
  end


end
