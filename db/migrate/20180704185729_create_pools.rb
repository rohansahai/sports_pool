class CreatePools < ActiveRecord::Migration[5.2]
  def change
    create_table :pools do |t|
      t.string :name
      t.integer :game_id, foreign_key: true, null: false
      t.text :initial_message
      t.string :phone_number

      t.timestamps
    end
  end
end
