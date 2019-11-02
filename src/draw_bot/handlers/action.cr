module DrawBot
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
      SplitParser.new({{data[0]}}, join_after: 1, min_args: 1),
      role_name_guard,
      CannedResponse.new("data/action",
        template: {{data[1]}}))
  {% end %}

  client.on_message_create(
    SplitParser.new("~spray", join_after: 1, min_args: 1),
    role_name_guard,
    CannedResponse.new("data/spray",
      template: "$author sprays $content with a $spray"))
end
