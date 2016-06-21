require_relative "required"

class Game
  attr_reader :board, :player_one, :player_two

  def initialize(player_one, player_two)
    @player_one, @player_two = board, player_one, player_two
    @board = Board.default_grid
  end


  # set up ini board
  # select & move
  # attk works
  #

end

if $PROGRAM_NAME == __FILE__
  b = Board.new
  d = Display.new(b)

  # debugger
  while true
    d.render
  end

end
