class CreateWebGamesTable < ActiveRecord::Migration
  def up
    create_table :web_games, force: true do |t|
      t.text :game
    end
  end

  def down
    drop_table :web_games
  end
end
