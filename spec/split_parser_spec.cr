require "./spec_helper"

module DrawBot
  describe SplitParser do
    it "parses message content as an array of strings" do
      message = json_fixture(Discord::Message, "message.json")
      message.content = "!command arg1 arg2 remaining message content"
      context = Discord::Context(Discord::Message).new(client, message)

      mw = SplitParser.new("!command",
        min_args: 2,
        max_args: 3,
        join_after: 3)
      called = mw.call(context, ->{ true })

      called.should be_true
      context.arguments.should eq [
        "arg1",
        "arg2",
        "remaining message content",
      ]
    end
  end
end
