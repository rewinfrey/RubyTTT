class AddWebGameToWebGameHistories < ActiveRecord::Migration
  def change
    drop_table :web_game_histories
    create_table :web_game_histories do |t|
    t.text :web_game
    t.string :player
    t.string :move
    end
  end
end
