# frozen_string_literal: true

describe Kozo::CLI do
  subject(:cli) { described_class.new(args) }

  describe "--verbose" do
    let(:args) { %w(--verbose) }

    it "turns on verbose output" do
      expect(cli.options[:verbose]).to eq true
    end
  end
end
