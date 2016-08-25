class Board
  attr_reader :grid, :previous_move

  def default_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = default_grid)
    @grid = grid
    place_pieces
  end

  def place_pieces

    {:black => 0, :white => 7}.each do |color, row|
      @grid[row][0] = Rook.new([row,0], self, color)
      @grid[row][1] = Knight.new([row,1], self, color)
      @grid[row][2] = Bishop.new([row,2], self, color)
      @grid[row][3] = Queen.new([row,3], self, color)
      @grid[row][4] = King.new([row,4], self, color)
      @grid[row][5] = Bishop.new([row,5], self, color)
      @grid[row][6] = Knight.new([row,6], self, color)
      @grid[row][7] = Rook.new([row,7], self, color)
    end

    @grid[1].each_with_index do |space, idx|
      @grid[1][idx] = Pawn.new([1,idx], self, :black)
    end

    @grid[6].each_with_index do |space, idx|
      @grid[6][idx] = Pawn.new([6,idx], self, :white)
    end

  end

  def move!(start_pos, end_pos) # Doesn't check for valid move, or update pieces' positions
    @previous_move = [start_pos, end_pos]
    @temp_rm_piece = self[end_pos]
    self[start_pos], self[end_pos] = nil, self[start_pos]
  end

  def move(start_pos, end_pos)
    begin
      valid_move?(start_pos, end_pos)
    rescue # StartingPosition => e
      # retry
    end
    move!(start_pos, end_pos)
    self[end_pos].position = end_pos
    @temp_rm_piece.position = nil if @temp_rm_piece.is_a?(Piece)
  end

  def undo_last_move
    start_pos, end_pos = @previous_move
    self[end_pos], self[start_pos] = @temp_rm_piece, self[end_pos]
  end

  def valid_move?(start_pos, end_pos)
    self[start_pos].valid_moves.include?(end_pos)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def in_check?(current_color)
    pos_king = find_king(current_color)
    other_color = current_color == :black ? :white : :black
    pieces_in_play(other_color).any? do |piece|
      return true if piece.possible_moves.include?(pos_king)
    end
    false
  end

  def checkmate?(current_color)
    return pieces_in_play(current_color).all? do |piece|
      piece.valid_moves.length == 0
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def find_king(color)
    pieces_in_play(color).each do |piece|
      return piece.position if piece.class == King
    end
    nil
  end

  def pieces_in_play(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end

end
