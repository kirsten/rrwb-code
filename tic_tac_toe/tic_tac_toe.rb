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
    if board[0,1] != '-' && board[0,1] == board[1,1] &&
        board[1,1] == board[2,1]
      return board[0,1]
    end
    if board[3,1] != '-' && board[3,1] == board[4,1] &&
        board[4,1] == board[5,1]
      return board[3,1]
    end
    if board[6,1] != '-' && board[6,1] == board[7,1] &&
        board[7,1] == board[8,1]
      return board[6,1]
    end
    return '-'
  end
end

class Board
  def initialize(board)
    @board = board.dup
  end
  
  def to_s
    @board
  end

  def [](start, stop = 1)
    @board[start, stop]
  end

  def place_mark_at(position, mark)
    @board[position] = mark 
  end

  def position_empty?(position)
    @board[position,1] == '-'
  end
end