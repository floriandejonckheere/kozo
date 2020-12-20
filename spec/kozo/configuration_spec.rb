# frozen_string_literal: true

RSpec.describe Kozo::Configuration do
  subject(:configuration) { described_class.new }

  it { is_expected.to respond_to :directory, :directory= }
  it { is_expected.to respond_to :verbose, :verbose= }

  describe "#[]" do
    it "gets the configuration value" do
      configuration.directory = "foobar"

      expect(configuration[:directory]).to eq "foobar"
    end
  end

  describe "#[]=" do
    it "sets the configuration value" do
      configuration[:directory] = "foobar"

      expect(configuration.directory).to eq "foobar"
    end
  end
end
