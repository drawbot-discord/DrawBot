require "./spec_helper"

module DrawBot
  def self.it_parses_command(string, with mw, into expected = [] of String)
    it "parses #{string} into #{expected}" do
      message = json_fixture(Discord::Message, "message.json")
      message.content = string
      context = Discord::Context.new
      context.put(client)

      mw.call(message, context) { true }.should be_true
      context[SplitParser::Results].arguments.should eq expected
    end
  end

  def self.it_ignores(string, with mw)
    it "ignores #{string}" do
      message = json_fixture(Discord::Message, "message.json")
      message.content = string
      context = Discord::Context.new
      context.put(client)
      mw.call(message, context) { true }.should be_falsey
    end
  end

  describe SplitParser do
    basic_parser = SplitParser.new("!command")

    it_parses_command("!command", with: basic_parser)
    it_parses_command("!ComMAnd", with: SplitParser.new("!cOMMand"))
    it_parses_command("!command arg1 arg2", with: basic_parser, into: ["arg1", "arg2"])
    it_parses_command(
      "!command arg1 arg2 remaining message content",
      with: SplitParser.new("!command", min_args: 2, max_args: 3, join_after: 3),
      into: ["arg1", "arg2", "remaining message content"]
    )

    it_ignores("!commandwithextratext", with: basic_parser)
    it_ignores("!completely wrong command", with: basic_parser)
  end
end
