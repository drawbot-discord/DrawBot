require "./spec_helper"

module DrawBot
  describe CannedResponse do
    it "raises when template invokes a source too many times" do
      expect_raises(CannedResponseError, "Template invokes $foo more times than its data pool can provide! 2 / 1") do
        CannedResponse.new({"foo" => ["bar"]}, "$foo $foo")
      end
    end

    describe "#produce_response" do
      it "builds a string with random data into a template" do
        instance = CannedResponse.new(
          {"foo" => ["bar"], "baz" => ["qux"]},
          "test $foo $baz"
        )
        instance.produce_response.should eq "test bar qux"
      end

      it "replaces $content with provided argument" do
        instance = CannedResponse.new({"foo" => ["bar"]}, "$content")
        instance.produce_response("baz").should eq "baz"
      end

      it "replaces $author with provided argument" do
        instance = CannedResponse.new({"foo" => ["bar"]}, "$author")
        instance.produce_response(nil, "baz").should eq "baz"
      end
    end
  end
end
