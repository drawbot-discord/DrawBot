module DrawBot
  client.on_message_create(
    SplitParser.new("~8ball", join_after: 1, min_args: 1),
    CannedResponse.new("data/fortune",
      template: "$author `$content`: $fortune"))

  # TODO: Add eris & zii
end
