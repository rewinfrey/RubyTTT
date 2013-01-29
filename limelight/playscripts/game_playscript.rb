class GamePlayscript
  attr_accessor :context, :game_id, :production
  def initialize(options)
    self.context    = options.fetch(:context)
    self.game_id    = options.fetch(:game_id)
    self.production = options.fetch(:production)
    self
  end

  def initialize_history
    production.context.initialize_history(game_id)
  end

  def view_history(index_diff)
    game = production.context.get_game(game_id)
    game.adjust_move_index(index_diff)
    production.context.save_game(game_id, game)
    process_game_history
  end

  def process_game_history
    history_board = production.context.get_history_board(game_id)
    update_context_board(history_board)
  end

  def display_results
    update_context_board
    display_move_history
    game_over_prompt
  end

  def game_move_index
    context.get_history(game_id).length
  end

  def current_move_index
    production.move_index
  end

  def generate_history_board
    game = context.get_game(game_id)
    game.history.move_traverser.adjust_move_index(production.move_index)
    game.history.move_traverser.history_board_builder(game.board, production.move_index)
  end

  def player_move(cell)
    @move = cell.id
    return unless valid_move? && not_finished?
    mark_move
    update_context_board
    update_move_history
    prompt_next_player
    display_results if finished?
    process_ai_move unless finished?
  end

  def process_ai_move
    return unless next_move_is_ai?
    ai_move
    update_context_board
    update_move_history
    prompt_next_player
    display_results if finished?
    if next_move_is_ai? && not_finished?
      sleep 1
      process_ai_move
    end
  end

  def which_board?
    production.context.which_board(@game_id)
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
      @context.find_by_id("player_turn").text = "#{winner} is the winner!"
    else
      @context.find_by_id("player_turn").text = "It's a draw"
    end
  end

  def update_context_board(new_board = board)
    new_board.each_with_index do |square, index|
      @context.find_by_id("square_text_#{index}").text = square
    end
  end

  def update_move_history
    history = production.context.get_history(@game_id)
    size    = history.size
    value   = history[size - 1]
    @context.find_by_id("move_history").text += "\n#{value.side} #{value.move}"
  end

  def display_move_history
    history = production.context.get_history(@game_id)
    @context.find_by_id("move_history").text = "Move History"
    result_string = ''
    history.each do |value|
      @context.find_by_id("move_history").text += "\n#{value.side} #{value.move}"
    end
  end

  def prompt_next_player
    @context.find_by_id("player_turn").text = "#{which_current_player?}'s turn"
  end

  def ai_move
    production.context.ai_move(@game_id)
  end

  def next_move_is_ai?
    production.context.ai_move?(@game_id)
  end

  def mark_move
    player = production.context.which_current_player?(@game_id)
    production.context.update_game(@game_id, move, player_side(player))
  end

  def player_side(player_num)
    if player_num == "Player 1"
      "x"
    else
      "o"
    end
  end

  def board
    production.context.board(@game_id)
  end

  def which_current_player?
    production.context.which_current_player?(@game_id)
  end

  def finished?
    production.context.finished?(@game_id)
  end

  def not_finished?
    !finished?
  end

  def winner?
    production.context.winner?(@game_id)
  end

  def winner
    production.context.winner(@game_id)
  end

  def valid_move?
    production.context.valid_move?(@game_id, move)
  end
end
