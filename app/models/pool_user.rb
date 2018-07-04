class PoolUser < ApplicationRecord
  belongs_to :user
  belongs_to :pool
  belongs_to :winner_pick, class_name: "Team"

  def send_initial_pool_message
    return if pool_inactive? || initial_message_sent_at

    # should probably denormalize or eager load some of this in the future
    game = pool.game
    home_team = game.home_team
    away_team = game.away_team

    # eventually can pull from initial message on pool record
    message = "#{pool.name}. Rohan Sahai has invited you to join his betting pool for" +
      " the #{valid_teams_pretty} #{game.sport} game. Respond to this message with your" +
      " pick and score predicition, in the format:" +
      " \n\n#{user_pick_format}.\n\n" +
      " The IDs are in brackets next to the name team names above. For example: " +
      " \n\n#{home_team.id}, 3-1\n\n" +
      " This would indicate #{home_team.name} wins the game 3 to 1.\n\n"
      " The entry fee is 1 dollar. The pick that is most accurate based on" +
      " winner and score will take all. Rohan will assume you are in if you respond to" +
      " this message."
    pool.send_message(message, user)
  end
end
