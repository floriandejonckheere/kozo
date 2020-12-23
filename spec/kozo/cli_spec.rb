# frozen_string_literal: true

describe Kozo::CLI do
  subject!(:cli) { described_class.new(args) }

  describe "--directory" do
    let(:args) { %w(--directory /foo/bar/..) }

    it "sets the working directory" do
      expect(Kozo.options.directory).to eq "/foo"
    end
  end

  describe "--verbose" do
    let(:args) { %w(--verbose) }

    it "turns on verbose output" do
      expect(Kozo.options).to be_verbose
    end
  end
end
