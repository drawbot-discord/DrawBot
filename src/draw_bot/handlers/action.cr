module DrawBot
  # We do this so we don't load the file a bunch of times into memory
  action_data = {"action" => File.read_lines("data/action")}

  # All handlers here guard on "playful" and "unlocknsfw"
  role_name_guard = RoleNameGuard.new("playful", "unlocknsfw")

  # These commands are all exactly the same, so we use a macro
  # to template them together in a neat fashion:
  {% for data in {
                   {"~wave", "$author $action waves $content"},
                   {"~boop", "$author $action boops $content"},
                   {"~slap", "$author $action slaps $content"},
                   {"~spank", "$author $action spanks $content"},
                   {"~rub", "$author $action rubs $content"},
                   {"~grope", "$author $action gropes $content"},
                   {"~hug", "$author $action hugs $content"},
                   {"~hump", "$author $action humps $content"},
                   {"~bite", "$author $action bites $content"},
                   {"~smack", "$author $action smacks $content"},
                   {"~punch", "$author $action punches $content"},
                   {"~noogie", "$author gives $content a noogie"},
                   {"~smell", "$author smells $content"},
                   {"~lick", "$author $action licks $content"},
                   {"~kick", "$author $action kicks $content"},
                   {"~chop", "$author $action karate chops $content"},
                   {"~squeeze", "$author $action squeezes $content"},
                   {"~arrest", "$author $action arrests $content"},
                   {"~sharpie", "$author draws all over $content with a sharpie"},
                   {"~dance", "$author $action dances with $content"},
                   {"~pat", "$author $action pats $content"},
                   {"~pet", "$author $action pets $content"},
                   {"~sit", "$author $action sits on $content"},
                   {"~tease", "$author $action teases $content"},
                   {"~whip", "$author $action whips $content"},
                   {"~murder", "$author $action murders $content"},
                   {"~wink", "$author $action winks at $content"},
                   {"~kiss", "$author gives $content a kiss"},
                   {"~lean", "$author $action leans on $content"},
                   {"~squish", "$author squishes $content - Quick, grab the broom!"},
                 } %}
    client.on_message_create(
      SplitParser.new({{data[0]}}, join_after: 1),
      role_name_guard,
      CannedResponse.new(action_data,
        template: {{data[1]}}))
  {% end %}

  client.on_message_create(
    SplitParser.new("~spray", join_after: 1),
    role_name_guard,
    CannedResponse.new({
      "container" => [
        "fire hose",
        "garden hose",
        "spray bottle",
        "water gun",
        "super soaker",
      ],
    },
      template: "$author sprays $content with a $container"))

  fight_data = {
    "extreme" => [
      "with extreme force",
      "with a nuke",
    ],
    "method" => [
      "with a hammer",
      "with a hatchet",
      "with a dick",
      "by sacrifice to the Lord of Terror",
      "telefragged",
      "with a 360NoScope",
      "with a stick of dynamite",
      "with a lobotomy",
      "with a fish",
      "with a shovel",
      "with a pencil",
      "with a pinecone",
      "with fists",
    ],
  }

  fight_map = {
    win:       CannedResponse.new(fight_data, template: "$author killed $content $method"),
    lose:      CannedResponse.new(fight_data, template: "$content killed $author $method"),
    win_crit:  CannedResponse.new(fight_data, template: "$author killed $author $extreme"),
    lose_crit: CannedResponse.new(fight_data, template: "$content killed $author $extreme"),
  }

  client.on_message_create(
    SplitParser.new("~fight", join_after: 1),
    role_name_guard) do |payload, context|
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
