require 'colorize'

class Display
  attr_reader :board, :cursor_pos
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def render
    # render_str = "  #{('A'..'H').to_a.join(" ")}\n"   ## WITH COLUMN HEADERS
    render_str = ""                                     ## NO COLUMN HEADERS
    @board.grid.each_with_index do |row, idx|
      # render_str += "#{idx} "                         ## WITH ROW HEADERS
      render_str += "   "                               ## NO ROW HEADERS

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

    puts render_str

  end

end
