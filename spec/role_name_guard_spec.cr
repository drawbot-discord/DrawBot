require "./spec_helper"

module DrawBot
  describe RoleNameGuard do
    instance = RoleNameGuard.new "foo", "bar"

    describe "#call" do
      guild = json_fixture(Discord::Guild, "guild.json")
      channel = json_fixture(Discord::Channel, "channel.json")
      member = json_fixture(Discord::GuildMember, "member.json")
      member.user.id = 0_u64
      member.roles = guild.roles.map &.id

      cache.cache(guild)
      cache.cache(channel)
      cache.cache(member, guild.id)

      it "passes when the bot has correct roles" do
        message = json_fixture(Discord::Message, "message.json")
        message.channel_id = channel.id
        context = Discord::Context(Discord::Message).new(client, message)
        instance.call(context, ->{ true }).should be_true
      end
    end

    describe "#build_response" do
      it "lists a single role" do
        string = instance.build_response %w(foo)
        string.should eq "I need the `foo` role to use this command!"
      end

      it "lists two roles" do
        string = instance.build_response %w(foo bar)
        string.should eq "I need the `foo` or `bar` role to use this command!"
      end

      it "lists three or more roles" do
        string = instance.build_response %w(foo bar baz)
        string.should eq "I need one of the `foo`, `bar`, or `baz` roles to use this command!"
      end
    end
  end
end
