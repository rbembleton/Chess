require_relative "required"

class Game
  attr_reader :board, :player_one, :player_two, :display, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @display = Display.new(@board)
    @current_player = @player_one
  end


  def play
    until won?
      play_turn
      switch_players
    end
    winner, color = @board.checkmate?(:black) ?
      [@player_one.name, :white] :
      [@player_two.name, :black]
    winner_display(winner, color)
  end

  def play_turn

    start_pos = half_turn(nil, nil) do |pos, _|
      @board[pos] && @board[pos].color == @current_player.color
    end

    while (start_pos == :undo) || (@board[start_pos].valid_moves.length == 0) do
      error_message = start_pos == :undo ?
        "Nothing is currently selected, please make a selection first" :
        "That piece has no valid moves, try again!"
      start_pos = half_turn(nil, error_message) do |pos, _|
        @board[pos] && @board[pos].color == @current_player.color
      end
    end

    end_pos = half_turn(start_pos, nil) do |end_pos, start_pos|
      @board.valid_move?(start_pos, end_pos)
    end

    if end_pos == :undo
      play_turn #starts play_turn again with no selection
    else
      @board.move(start_pos, end_pos)
    end
  end

  def half_turn(previous, message, &prc)
    position = nil
    previous_txt = previous ? @board[previous].class : "Nothing is selected"
    until position && ((position == :undo) || prc.call(position, previous))
      turn_display(previous, previous_txt, message)
      position = @current_player.get_input(@display, @board, previous) ## either pos or :undo
      # position = @display.get_input ## either pos or :undo
    end
    position
  end

  def turn_display(previous, previous_txt, message)
    system("clear")
    puts  "Player: #{@current_player.name}, Color: #{@current_player.color.capitalize}"
    puts "Selected: #{previous_txt}"
    # puts "Possible Moves: #{@board[previous].possible_moves}" if previous   ## FOR TESTING
    # puts "Valid Moves: #{@board[previous].valid_moves}" if previous         ## FOR TESTING
    puts "#{message}" if message
    puts " " unless message #|| previous                                      ## FOR TESTING
    @display.render
    puts "#{@current_player.color.capitalize} is in Check!" if @board.in_check?(@current_player.color)

    puts "\n\nControls:\nMove: LEFT, RIGHT, UP, DOWN or A, D, W, S\nSelect: ENTER or SPACE\nDeselect: BACKSPACE"
  end

  def winner_display(winner, color)
    system("clear")
    puts  "\n#{color.capitalize} is in Checkmate. #{winner} wins!\n\n"
    @display.render
    puts "\n\n"
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def won?
    return true if @board.checkmate?(@current_player.color)
    return true unless @board.find_king(:black) && @board.find_king(:white)
  end


end

if $PROGRAM_NAME == __FILE__
  system("clear")
  puts "Welcome to Chess! What is your name?"
  name = gets.chomp
  player_one = HumanPlayer.new(name, :white)

  puts "Nice to meet you, #{name}! Do you want to play against me, the computer? (y or n)"
  computer_y = gets.chomp
  if computer_y.downcase == 'y'
    player_two = ComputerPlayer.new(:black)
  else
    puts "What is the name of the second player?"
    name = gets.chomp
    player_two = HumanPlayer.new(name, :black)
    puts "Welcome, #{name}!"
  end

  puts "Alright, press any key to get started."
  gets

  chess_game = Game.new(player_one, player_two)
  chess_game.play
end
