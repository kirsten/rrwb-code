class Game
  def initialize(board, position=nil, player=nil)
    @board = board.dup
    place_mark_at(position, player) unless position == nil
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
    (0..8).each { |position| empty_position = position if mark_at(position) == '-'; break if empty_position }
    empty_position
  end

  def position_empty?(position)
    mark_at(position) == '-'
  end

  def play(i, player)
    Game.new(board, i, player)
  end

  def winner
    if mark_at(0) != '-' && mark_at(0) == mark_at(1) && mark_at(1) == mark_at(2)
      return mark_at(0)
    end
    if mark_at(3) != '-' && mark_at(3) == mark_at(4) && mark_at(4) == mark_at(5)
      return mark_at(3)
    end
    if mark_at(6) != '-' && mark_at(6) == mark_at(7) && mark_at(7) == mark_at(8)
      return mark_at(6)
    end
    return '-'
  end

  private

  def mark_at(starting)
    board[starting, 1]
  end

  def place_mark_at(position, player)
    board[position] = player
  end

  def board
    @board
  end
end
