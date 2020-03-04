class Game
  attr_accessor :board

  BLANK_SPACE = "-".freeze

  def initialize(board, position=nil, player=nil)
    @board = board.dup
    @board[position] = player if position != nil
  end

  def move(player)
    (0..8).each do |position|
      if space_available?(position)
        game = play(position, player)
        return position if game.winner() == player
      end
    end

    (0..8).each { |position| return position if space_available?(position) }
    return -1
  end

  def space_available?(position)
    board[position] == BLANK_SPACE
  end

  def play(i, player)
    Game.new(board, i, player)
  end

  def winner
    if !space_available?(0) && board[0] == board[1] &&
        board[1] == board[2]
      return board[0,1]
    end
    if !space_available?(3) && board[3] == board[4] &&
        board[4] == board[5]
      return board[3]
    end
    if !space_available?(6) && board[6] == board[7] &&
        board[7] == board[8]
      return board[6]
    end
    return BLANK_SPACE
  end
end
