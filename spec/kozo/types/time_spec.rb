# frozen_string_literal: true

RSpec.describe Kozo::Types::Time do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to be_nil
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
end
