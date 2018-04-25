module DrawBot
  fight_map = {
    win: CannedResponse.new(
      "data/fight_method",
      template: "**$author** killed **$content** $fight_method!"),
    lose: CannedResponse.new(
      "data/fight_method",
      template: "**$content** killed **$author** $fight_method!"),
    win_crit: CannedResponse.new(
      "data/fight_extreme",
      template: "**$author** killed **$content** $fight_extreme!"),
    lose_crit: CannedResponse.new(
      "data/fight_extreme",
      template: "**$content** killed **$author** $fight_extreme!"),
  }

  client.on_message_create(
    SplitParser.new("~fight", join_after: 1),
    RoleNameGuard.new("playful", "unlocknsfw")) do |payload, context|
    a, b = rand(1..20), rand(1..20)
    if a > b
      if a == 20
        fight_map[:win_crit].call(payload, context)
      else
        fight_map[:win].call(payload, context)
      end
    elsif b > a
      if b == 20
        fight_map[:lose_crit].call(payload, context)
      else
        fight_map[:lose].call(payload, context)
      end
    elsif a == b
      client.create_message(
        payload.channel_id,
        "It's a tie! RE-ROLL!")
    end
  end
end
