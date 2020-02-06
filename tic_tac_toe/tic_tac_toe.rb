class Game
  attr_accessor :board

  def initialize(board_s, position=nil, player=nil)
    @board = Board.new(board_s)
    @board.place_mark_at(position, player) if position != nil
  end

  def move(player)
    winning_move = find_winning_move(player)
    return winning_move if winning_move

    return find_first_empty_position if find_first_empty_position
    return -1
  end

  def find_winning_move(player)
    winning_move = nil
    (0..8).each do |position|
      if @board.position_empty?(position)
        game = play(position, player)
        winning_move = position if game.winner() == player
      end
    end
    winning_move
  end

  def find_first_empty_position
    empty_position = nil 
    (0..8).each { |position| empty_position = position if @board.position_empty?(position); break if empty_position }
    empty_position
  end

  def play(i, player)
    Game.new(board.to_s, i, player)
  end

  def winner
    if row_is_the_same_player(0)
      return board[0]
    end
    if row_is_the_same_player(3)
      return board[3]
    end
    if row_is_the_same_player(6)
      return board[6]
    end
    return '-'
  end

  def row_is_the_same_player(row)
    board[row] != '-' && board[row] == board[row + 1] && board[row + 1] == board[row + 2]
  end
end

class Board
  def initialize(board)
    @board = board.dup
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
