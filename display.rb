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
        if [idx, idx2] == cursor_pos
          # debugger
          render_str += "  ".colorize(:background => :red) if (idx + idx2).even?
          render_str += "  ".colorize(:background => :light_red) if (idx + idx2).odd?
        elsif tile.nil?
          render_str += "  ".colorize(:background => :light_black) if (idx + idx2).even?
          render_str += "  ".colorize(:background => :light_white) if (idx + idx2).odd?
        else
          render_str += "__".colorize(:blue)
          # render_str += tile.to_s
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
d = Display.new(b)
# debugger
while true
  d.render
end
