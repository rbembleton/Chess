class ComputerPlayer < Player

  def initialize(color)
    super("Computer", color)
  end


  def get_input(display, board, previous)
    @board = board
    previous == nil ? piece_selection : move_selection(previous)
  end

  def piece_selection
    @board.pieces_in_play(self.color).each do |piece|
      return piece.position if check_for_attack(piece)
    end

    #Random piece
    @board.pieces_in_play(self.color).shuffle.each do |piece|
      return piece.position if piece.valid_moves.length > 0
    end
  end

  def move_selection(previous)
    attack_move = check_for_attack(@board[previous])
    return attack_move if attack_move

    #Random move
    @board[previous].valid_moves.sample
  end

  def check_for_attack(piece)
    piece.valid_moves.each do |move|
      if @board[move] && @board[move].color == other_color
        return move
      end
    end
    nil
  end


  def other_color
    self.color == :black ? :white : :black
  end

end
