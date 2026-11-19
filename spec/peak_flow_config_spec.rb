require "spec_helper"
require "yaml"

describe "peak_flow.yml" do
  let(:config) { YAML.load_file(File.expand_path("../peak_flow.yml", __dir__)) }

  it "declares a paths filter" do
    expect(config["paths"]).to be_an(Array)
  end

  it "keeps the whole repository inside the positive rule" do
    expect(config["paths"]).to include("**")
  end

  it "writes every negation as a quoted string, never as a bare YAML tag" do
    expect(config["paths"]).to all(be_a(String))
  end

  it "excludes only the CI configuration directory" do
    expect(config["paths"].select { |pattern| pattern.start_with?("!") }).to eq(["!.github/**"])
  end
end
