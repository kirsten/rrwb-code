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

  def row_has_three_equal_values?(row_starting_position)
    !space_available?(row_starting_position) &&
    board[row_starting_position] == board[row_starting_position + 1] &&
    board[row_starting_position + 1] == board[row_starting_position + 2]
  end

  def winner
    return board[0] if row_has_three_equal_values?(0)
    return board[3] if row_has_three_equal_values?(3)
    return board[6] if row_has_three_equal_values?(6)
    return BLANK_SPACE
  end
end
