# frozen_string_literal: true

RSpec.describe Kozo::Options do
  subject(:options) { described_class.new }

  it { is_expected.to respond_to :directory, :directory?, :directory= }
  it { is_expected.to respond_to :verbose, :verbose?, :verbose= }

  describe "#[]" do
    it "gets the option value" do
      options.directory = "/foobar"

      expect(options[:directory]).to eq "/foobar"
    end
  end

  describe "#[]=" do
    it "sets the option value" do
      options[:directory] = "/foobar"

      expect(options.directory).to eq "/foobar"
    end
  end
end
