# frozen_string_literal: true

RSpec.describe Kozo::Types::Time do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "does not cast time" do
      expect(described_class.cast(Time.new(2000, 1, 1))).to eq Time.new(2000, 1, 1)
    end

    it "casts a time value" do
      expect(described_class.cast("2000-01-01")).to eq Time.new(2000, 1, 1)
      expect(described_class.cast("2000-01-01T12:00:00Z")).to eq Time.find_zone("UTC").local(2000, 1, 1, 12)

      ActiveSupport::TimeZone
    end

    it "does not cast invalid values" do
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end

  describe ".as_json" do
    it "does not serialize nil" do
      expect(described_class.as_json(nil)).to eq nil
    end

    it "serializes times correctly" do
      expect(described_class.as_json(Time.find_zone("UTC").local(2000, 1, 1, 12))).to eq "2000-01-01T12:00:00Z"
    end
  end

  describe ".as_s" do
    it "serializes nil" do
      expect(described_class.as_s(nil)).to eq "nil"
    end

    it "serializes times correctly" do
      expect(described_class.as_s(Time.find_zone("UTC").local(2000, 1, 1, 12))).to eq "2000-01-01 12:00:00 UTC"
    end
  end
end
