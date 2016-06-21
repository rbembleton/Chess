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


  def obstruction?(x, y)
    return false unless x.between?(0,7) && y.between?(0,7)
    return false if @board[x, y].nil?
    return true if self.same_color?(@board[x, y])
  end

  def diagonal
    x, y = @position

    #positive slope diagonals

    if x > 0 && y < 7
      (x - 1).downto(0) do |ix|
        (y + 1).upto(7) do |iy|
          break if self.same_color?(@board[(ix, iy)])
          @possible_moves << [ix, iy]
          break if self.other_color?(@board[(ix, iy)])


    end

  end

  #RIP
  # def vertical
  #   x, y = @position
  #   if x > 0
  #     (x - 1).downto(0) do |i|
  #       break if self.same_color?(@board[(i, y)])
  #       @possible_moves << [i, y]
  #       break if self.other_color?(@board[(i, y)])
  #     end
  #   end
  #   if y < 7
  #     (y + 1).upto(7) do |i|
  #       break if self.same_color?(@board[(i, y)])
  #       @possible_moves << [i, y]
  #       break if self.other_color?(@board[(i, y)])
  #     end
  #   end
  #
  # end
  #
  # def horizontal
  #   x, y = @position
  #   if y > 0
  #     (y - 1).downto(0) do |i|
  #       break if self.same_color?(@board[(x,i)])
  #       @possible_moves << [x, i]
  #       break if self.other_color?(@board[(x,i)])
  #     end
  #   end
  #   if y < 7
  #     (y + 1).upto(7) do |i|
  #       break if self.same_color?(@board[(x,i)])
  #       @possible_moves << [x, i]
  #       break if self.other_color?(@board[(x,i)])
  #     end
  #   end
  # end

  def method_name

  end

end
