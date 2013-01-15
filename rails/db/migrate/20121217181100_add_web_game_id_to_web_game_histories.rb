class AddWebGameIdToWebGameHistories < ActiveRecord::Migration
  def change
    add_column :web_game_histories, :web_game_id, :integer
  end
end
