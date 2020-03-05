class Game
  attr_accessor :board

  NO_MOVES_LEFT = -1

  def initialize(board_s, position=nil, player=nil)
    @board = Board.new(board_s)
    @board.place_mark_at(position, player) if position != nil
  end

  def move(player)
    winning_move = find_winning_move(player)
    return winning_move if winning_move

    return find_first_empty_position if find_first_empty_position
    return NO_MOVES_LEFT
  end

  def find_winning_move(player)
    winning_move = nil
    (0..8).each do |position|
      if board.position_empty?(position)
        game = play(position, player)
        winning_move = position if game.winner() == player
      end
    end
    winning_move
  end

  def find_first_empty_position
    empty_position = nil 
    (0..8).each { |position| empty_position = position if board.position_empty?(position); break if empty_position }
    empty_position
  end

  def play(i, player)
    Game.new(board.to_s, i, player)
  end

  def winner
    board.rows.each do |row|
      if board.row_is_the_same_player(starting_position(row))
        winning_mark = board[starting_position(row)]
        return winning_mark
      end
    end
    return '-'
  end

  def starting_position(row)
    row * 3
  end
end

class Board
  def initialize(board)
    @board = board.dup
  end

  def rows
    (0...2)
  end

  def row_is_the_same_player(position)
    !position_empty?(position) && @board[position] == @board[position + 1] && @board[position + 1] == @board[position + 2]
  end

  def to_s
    @board
  end

  def [](position)
    @board[position, 1]
  end

  def place_mark_at(position, mark)
    @board[position] = mark
  end

  def position_empty?(position)
    @board[position,1] == '-'
  end
end
