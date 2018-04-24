module DrawBot
  fight_map = {
    win: CannedResponse.new(
      "data/fightmethod",
      template: "**$author killed $content $fightmethod!**"),
    lose: CannedResponse.new(
      "data/fightmethod",
      template: "**$content killed $author $fightmethod!**"),
    win_crit: CannedResponse.new(
      "data/fightextreme",
      template: "**$author killed $author $fightextreme!**"),
    lose_crit: CannedResponse.new(
      "data/fightextreme",
      template: "**$content killed $author $fightextreme!**"),
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
