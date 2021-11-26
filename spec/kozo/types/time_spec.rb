# frozen_string_literal: true

RSpec.describe Kozo::Types::Time do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "casts a time value" do
      expect(described_class.cast("2000-01-01")).to eq Time.new(2000, 1, 1)
      expect(described_class.cast("2000-01-01T12:00:00+01:00")).to eq Time.new(2000, 1, 1, 12)
    end

    it "does not cast invalid values" do
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end

  describe ".serialize" do
    it "serializes times correctly" do
      expect(described_class.serialize(Time.new(2000, 1, 1, 12))).to eq "2000-01-01T12:00:00+01:00"
    end
  end
end
