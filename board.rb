class Board
  attr_reader :grid

  def default_grid
    Array.new(8) { Array.new(8) }
  end

  def initialize(grid = default_grid)
    @grid = grid
  end

  def move(start_pos, end_pos)
    begin
      valid_move?(start_pos, end_pos)
    rescue # StartingPosition => e
      # retry
    end
    @grid[start_pos], @grid[end_pos] = nil, @grid[start_pos]
  end

  def valid_move?(start_pos, end_pos)

    if self[start_pos].nil?
      raise StartingPosition.new ("There is no piece there")
    end
    # self[start].valid_move?

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
  end

  def pieces_in_play(color)
    @grid.flatten.select {|piece| piece.color == color}
  end

end
