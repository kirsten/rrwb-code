class Game
  def initialize(board, position=nil, player=nil)
    @board = Board.new(board.dup)
    @board.place_mark_at(position, player) unless position == nil
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
      if position_empty?(position)
        game = play(position, player)
        winning_move = position if game.winner() == player
      end
    end
    winning_move
  end

  def find_first_empty_position
    empty_position = nil
    (0..8).each { |position| empty_position = position if position_empty?(position); break if empty_position }
    empty_position
  end

  def play(i, player)
    Game.new(board.to_s, i, player)
  end

  def winner
    return mark_at(0) if player_wins_row?(0)
    return mark_at(3) if player_wins_row?(3)
    return mark_at(6) if player_wins_row?(6)

    return '-'
  end

  private

  def player_wins_row?(row_start)
    if !position_empty?(row_start) &&
        mark_at(row_start) == mark_at(row_start + 1) &&
        mark_at(row_start + 1) == mark_at(row_start + 2)
      return mark_at(row_start)
    end
  end

  def position_empty?(position)
    board.position_empty?(position)
  end

  def mark_at(starting)
    board.mark_at(starting)
  end

  def board
    @board
  end
end

class Board
  def initialize(board)
    @board = board
  end

  def to_s
    @board
  end

  def mark_at(position)
    @board[position]
  end

  def place_mark_at(position, mark)
    @board[position] = mark
  end

  def position_empty?(position)
    mark_at(position) == '-'
  end
end
