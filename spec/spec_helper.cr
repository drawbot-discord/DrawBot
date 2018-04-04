require "spec"
require "../src/draw_bot"

# Helper for loading JSON data objects
macro json_fixture(klass, file)
  {{klass}}.from_json File.read("spec/data/" + {{file}})
end
