# frozen_string_literal: true

RSpec.describe Kozo::Types::Date do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to be_nil
    end

    it "does not cast a date" do
      expect(described_class.cast(Date.new(2000, 1, 1))).to eq Date.new(2000, 1, 1)
    end

    it "casts a date value" do
      expect(described_class.cast("2000-01-01")).to eq Date.new(2000, 1, 1)
      expect(described_class.cast("2000-01-01T12:00:00+01:00")).to eq Date.new(2000, 1, 1)
    end

    it "does not cast invalid values" do
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end
end
