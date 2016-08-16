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
    winner = @board.find_king(:white) ? @player_one.name : @player_two.name
    winner_display(winner)
  end

  def play_turn

    start_pos = half_turn(nil, nil) do |pos, _|
      @board[pos] && @board[pos].color == @current_player.color
    end

    while @board[start_pos].possible_moves.length == 0 do
      start_pos = half_turn(nil, "That piece has no valid moves, try again!") do |pos, _|
        @board[pos] && @board[pos].color == @current_player.color
      end
    end

    end_pos = half_turn(start_pos, nil) do |end_pos, start_pos|
      @board.valid_move?(start_pos, end_pos)
    end

    @board.move(start_pos, end_pos)
  end

  def half_turn(previous, message, &prc)
    position = nil
    previous_txt = previous ? @board[previous].class : "None was selected"
    until position && prc.call(position, previous)
      turn_display(previous, previous_txt, message)
      position = @display.get_input
    end
    position
  end

  def turn_display(previous, previous_txt, message)
    system("clear")
    puts  "Player: #{@current_player.name}, Color: #{@current_player.color.capitalize}"
    puts "Selected: #{previous_txt}"
    puts "Possible Moves: #{@board[previous].possible_moves}" if previous
    puts "#{message}" if message
    puts " " unless previous || message
    @display.render
  end

  def winner_display(winner)
    system("clear")
    puts  "\n#{winner} wins!\n\n"
    @display.render
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def won?
    return true unless @board.find_king(:black) && @board.find_king(:white)
  end


end

if $PROGRAM_NAME == __FILE__
  # puts "Welcome to Chess! What is your name?"
  # name = gets.chomp
  # puts "Nice to meet you, #{name}! Press ENTER to start the game :D"
  # input = gets

  chess_game = Game.new("Bob the Drag Queen","RB")
  chess_game.play
end
