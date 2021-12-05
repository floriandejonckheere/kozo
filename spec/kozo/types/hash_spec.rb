# frozen_string_literal: true

RSpec.describe Kozo::Types::Hash do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "does not cast a hash" do
      expect(described_class.cast({ foo: "bar" })).to eq({ foo: "bar" })
    end

    it "casts a nested array" do
      expect(described_class.cast([[:foo, "bar"]])).to eq foo: "bar"
    end

    it "does not cast invalid values" do
      expect { described_class.cast([:foo, "bar"]) }.to raise_error ArgumentError
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end
end
