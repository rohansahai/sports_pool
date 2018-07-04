class Pool < ApplicationRecord
  belongs_to :game
  has_many :pool_users

  def valid_teams_pretty
    home_team = game.home_team
    away_team = game.away_team
    "#{home_team.name}[ID: #{home_team.id}] - #{away_team.name}[ID: #{away_team.id}]"
  end

  def pool_inactive?
    # a pool must be assigned a phone number before it's active
    !phone_number
  end

  def user_pick_format
    "WINNING_TEAM_ID, WINNING_TEAM_SCORE-LOSING_TEAM_SCORE"
  end

  # All these validations will have to be way more robust for this parser to work reliably.
  def parse_incoming_message(message, user)
    winning_team_id, score = message.split(",")
    if !winning_team_id || !score
      send_message("Invalid format detected. Valid format: #{user_pick_format}." +
       " Valid teams: #{valid_teams_pretty}")
      return
    end

    if !Team.find(winning_team_id)
      send_message(
        "Invalid Team ID for this pool. Valid teams: #{valid_teams_pretty}",
        user,
      )
      return
    end

    home_team_score, away_team_score = score.split("-").map(&:strip)
    if !home_team_score || !away_team_score
      send_message("Invalid Score Format detected. The score should have the winning" +
       " teams total first, and the losing teams second, separated by a dash.")
      return
    end
  end

  def send_message(message, user)
    puts message
    puts "Sent to #{user.name}"
    # begin
    #   twilio_client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
    #   twilio_client.messages.create(
    #     from: ENV['TWILIO_PHONE_NUMBER'],
    #     to: user.phone_number,
    #     body: message
    #   )
    # rescue Twilio::REST::RequestError => e
    #   logger.error("Error sending twilio message to user #{name}")
    # end
  end
end
