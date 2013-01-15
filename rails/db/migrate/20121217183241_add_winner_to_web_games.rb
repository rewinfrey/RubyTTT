class AddWinnerToWebGames < ActiveRecord::Migration
  def change
    add_column :web_games, :winner, :string
  end
end
