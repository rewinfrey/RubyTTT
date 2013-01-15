class GamePlayscript
  attr_accessor :context, :game
  def initialize(options)
    self.context = options.fetch(:context)
    self.game    = options.fetch(:game)
  end

  def player_move(cell)
    @move = cell.id
    return unless valid_move? && not_finished?
    mark_move
    record_move
    switch_player
    update_context_board
    update_move_history
    prompt_next_player
    game_over_prompt if finished?
    process_ai_move
  end

  def process_ai_move
    return unless next_move_is_ai?
    ai_move
    update_context_board
    update_move_history
    prompt_next_player
    game_over_prompt if finished?
    if next_move_is_ai? && not_finished?
      sleep 1
      process_ai_move
    end
  end

  def which_board?
    @game.which_board?
  end

  def set_move(cell)
    @move = cell.id
  end

  def move
    cell_location.to_i
  end

  def cell_location
    return @move[-2..-1] if @move[-2..-1] !~ (/[a-z]/i)
    @move[-1..-1]
  end

  def game_over_prompt
    if winner?
      @context.find_by_id("player_turn").text = winner
    else
      @context.find_by_id("player_turn").text = "It's a draw"
    end
  end

  def update_context_board
    board.each_with_index do |square, index|
      @context.find_by_id("square_text_#{index}").text = square
    end
  end

  def update_move_history
    history = @game.show_history
    size    = history.size
    value   = history[size]
    @context.find_by_id("move_history").text += "\n#{value[:side]} #{value[:move]}"
  end

  def prompt_next_player
    @context.find_by_id("player_turn").text = "#{which_current_player?} turn"
  end

  def ai_move
    @game.next_move
  end

  def next_move_is_ai?
    @game.ai_move?
  end

  def mark_move
    @game.mark_move(move)
  end

  def record_move
    @game.record_move(move)
  end

  def switch_player
    @game.switch_player
  end

  def board
    @game.board[]
  end

  def which_current_player?
    @game.which_current_player?
  end

  def finished?
    @game.board.finished?
  end

  def not_finished?
    !finished?
  end

  def winner?
    @game.board.winner?
  end

  def winner
    @game.switch_player
    if @game.current_player == @game.player1
      "Player 1 is the winner"
    else
      "Player 2 is the winner"
    end
  end

  def valid_move?
    @game.board.free?(move)
  end
end
