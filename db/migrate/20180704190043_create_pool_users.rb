class CreatePoolUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pool_users do |t|
      t.integer :pool_id, foreign_key: true, null: false
      t.integer :user_id, foreign_key: true, null: false
      t.integer :winner_pick_id, foreign_key: true, null: false
      t.integer :home_team_score
      t.integer :away_team_score
      t.integer :rank
      t.timestamp, :initial_message_sent_at

      t.timestamps
    end
  end
end
