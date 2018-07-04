class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :sport, null: false
      t.integer :home_team_id, foreign_key: true, null: false
      t.integer :away_team_id, foreign_key: true, null: false
      t.integer :home_team_score
      t.integer :away_team_score
      t.integer :winner_id

      t.timestamps
    end
  end
end
