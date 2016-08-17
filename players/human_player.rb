class HumanPlayer < Player

  def initialize(name, color)
    super(name, color)
  end

  def get_input(display, board, previous)
    display.get_input
  end

end
