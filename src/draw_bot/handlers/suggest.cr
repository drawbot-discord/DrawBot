module DrawBot
  client.on_message_create(
    SplitParser.new("~suggest", join_after: 1, min_args: 1)
  ) do |payload, context|
    message = context[SplitParser::Results].arguments.join(' ')

    channel = cache.resolve_channel(payload.channel_id)
    guild_name = if guild_id = payload.guild_id
                   cache.resolve_guild(guild_id).name
                 else
                   "DM"
                 end

    created_in = <<-CREATED
    Server: **#{guild_name}**
    Channel: **#{channel.name || payload.channel_id}**
    User: **#{payload.author.username}##{payload.author.discriminator} (#{payload.author.id})**
    CREATED

    embed = Discord::Embed.new(
      title: "New Suggestion",
      description: message,
      fields: [
        Discord::EmbedField.new(
          name: "__**Created In**__",
          value: created_in
        ),
      ],
      footer: Discord::EmbedFooter.new(text: "Ref Num: #{payload.id}")
    )

    client.create_message(
      config.suggestions_channel,
      "",
      embed
    )
    client.create_message(
      payload.channel_id,
      "",
      Discord::Embed.new(
        title: "I went ahead and submitted your suggestion!",
        # TODO: change discord invite to a config value or something.
        description: "[Be sure to join my development server to discuss your idea.](https://discord.gg/rYJrhSH)",
        colour: 0x08FF1F,
      )
    )
  end
end
