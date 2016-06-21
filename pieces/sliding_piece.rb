class SlidingPiece < Piece
#Bishop Rook Queen
  def move_dirs

  end

  def move
    move_dirs.each do |dx, dy|
      @possible_moves += find_move(dx, dy)
    end
  end

  def find_move(dx, dy)
    x, y = @position
    temp_moves = []
    until obstruction?((x + dx), (y + dy))
      x += dx
      y += dy
      temp_moves << [x, y]
      break if self.other_color?(@board[x, y])
    end
    temp_moves
  end


  def method_name

  end

end
