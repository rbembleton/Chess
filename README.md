# Chess

This was started as a project in class with Mac, but expanded Solo to be fully functional, and include a computer AI.

This game features
- OOP
- class inheritance
- error handling
- computer AI
- DRY code

## Running Chess

1. First download the zip file [here](https://github.com/rbembleton/Chess/archive/master.zip)
2. Make sure Ruby is installed by running `ruby -v` in your console
  - If it isn't go to this [website](http://installrails.com/steps/choose_os) for installation instruction
3. Unzip and navigate to the folder using terminal
4. Run `bundle install` and then `ruby chess.rb`
5. Have fun! :D



## ...OK. That all sounds good... but could you walk me through it a bit more?

Sure! Here are some screenshots to help get you started:

`bundle install` - you should see the gem `colorize` install
![bundle_install](docs/bundle_install.png)

`ruby chess.rb` - if this doesn't work check your Ruby version with `ruby -v` and make sure it is 2.0 or higher
![bundle_install](docs/ruby_chess.png)

Welcome page - enter your name and specify if you'd like to play against the computer AI or a friend
![entry_screen](docs/entry_screen.png)

Who needs friends when you have a computer to play Chess against?!
![computer_v_human](docs/computer_v_human.png)

Follow the on screen controls to navigate, and enjoy!
(For optimal game play zoom in using ⌘+)
![main_page](docs/main_page.png)


## Implementation

To check for valid moves Chess uses to `move` methods: one which will move regardless of whether the move is valid or not, and the other which will check that the move is valid before proceeding.

```ruby
## board.rb

def move!(start_pos, end_pos) # Doesn't check for valid move, or update pieces' positions
  @previous_move = [start_pos, end_pos]
  @temp_rm_piece = self[end_pos]
  self[start_pos], self[end_pos] = nil, self[start_pos]
end

def move(start_pos, end_pos)
  begin
    valid_move?(start_pos, end_pos)
  rescue StartingPosition => e
    retry
  end
  move!(start_pos, end_pos)
  self[end_pos].position = end_pos
  @temp_rm_piece.position = nil if @temp_rm_piece.is_a?(Piece)
end

```

This is necessary because `valid_move` calls the `piece::valid_moves` which then calls `move!` to check whether a move is valid or not, and so this prevents it from calling itself and entering into an infinite loop.

```ruby
## board.rb

def valid_move?(start_pos, end_pos)
  self[start_pos].valid_moves.include?(end_pos)
end

## piece.rb

def valid_moves # King has his own
  temp_valid_moves = []
  possible_moves.each do |move|
    @board.move!(self.position, move)
    temp_valid_moves << move unless @board.in_check?(self.color)
    @board.undo_last_move
  end
  temp_valid_moves
end

```
