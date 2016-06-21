require "colorize"
require_relative 'required'
require 'byebug'

class Display
  attr_reader :board, :cursor_pos
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def render
    render_str = "  #{('A'..'H').to_a.join(" ")}\n"
    @board.grid.each_with_index do |row, idx|
      render_str += "#{idx} "
      row.each_with_index do |tile, idx2|
          
        background = (idx + idx2).even? ? :light_black : :light_white

        if [idx, idx2] == cursor_pos
          background = (idx + idx2).even? ? :red : :light_red
        end

        if tile.nil?
          render_str += "  ".colorize(:background => background)
        else
          render_str += (tile.icon + " ").colorize(:color => tile.color, :background => background)
        end

      end
      render_str += "\n"
    end
    system("clear")
    # debugger
    puts render_str
    get_input
  end

end

b = Board.new
q = Queen.new( [0,0] , b, :white)
b[[0,0]] = q
d = Display.new(b)

# debugger
while true
  d.render
end
