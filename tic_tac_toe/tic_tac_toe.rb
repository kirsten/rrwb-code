class Game
  def initialize(board, position=nil, player=nil)
    @board = board.dup
    update_board(position, player) unless position == nil
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
      if position_empty?(get_board, position)
        game = play(position, player)
        winning_move = position if game.winner() == player
      end
    end
    winning_move
  end

  def find_first_empty_position
    empty_position = nil
    (0..8).each { |position| empty_position = position if get_board[position,1] == '-'; break if empty_position }
    empty_position
  end

  def position_empty?(board, position)
    get_board[position,1] == '-'
  end

  def play(i, player)
    Game.new(get_board, i, player)
  end

  def winner
    if get_board[0,1] != '-' && get_board[0,1] == get_board[1,1] &&
        get_board[1,1] == get_board[2,1]
      return get_board[0,1]
    end
    if get_board[3,1] != '-' && get_board[3,1] == get_board[4,1] &&
        get_board[4,1] == get_board[5,1]
      return get_board[3,1]
    end
    if get_board[6,1] != '-' && get_board[6,1] == get_board[7,1] &&
        get_board[7,1] == get_board[8,1]
      return get_board[6,1]
    end
    return '-'
  end

  private

  def get_board
    @board
  end

  def update_board(position, player)
    @board[position] = player
  end
end
