require_relative "required"

class Game
  attr_reader :board, :player_one, :player_two, :display, :current_player

  def initialize(player_one, player_two)
    @player_one = Player.new(player_one, :white)
    @player_two = Player.new(player_two, :black)
    @board = Board.new
    @display = Display.new(@board)
    @current_player = @player_one
  end


  def play
    until won?
      play_turn
      switch_players
    end
    #someone won
  end

  def play_turn

    start_pos = half_turn(nil) do |pos, _|
      @board[pos] && @board[pos].color == @current_player.color
    end
    # debugger
    end_pos = half_turn(start_pos) do |end_pos, start_pos|
      # p "S: #{start_pos}  E: #{end_pos}"
      @board.valid_move?(start_pos, end_pos)
    end

    @board.move!(start_pos, end_pos)
  end

  def half_turn(previous, &prc)
    position = nil
    previous_txt = previous ? @board[previous].class : "None was selected"
    until position && prc.call(position, previous)

      system("clear")

      puts  "Player: #{@current_player.name}, Color: #{@current_player.color.capitalize}"
      puts "Selected: #{previous_txt}"
      puts "Possible Moves: #{@board[previous].moves}" if previous
      @display.render

      position = @display.get_input
    end
    position
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def won?
    #
    false
  end


end

if $PROGRAM_NAME == __FILE__
  our_chess = Game.new("RB","Mac")
  our_chess.play
  #
  # b = Board.new
  #
  #
  # d = Display.new(b)
  #
  # # debugger
  # while true
  #   d.render
  # end

end
