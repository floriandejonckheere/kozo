# frozen_string_literal: true

RSpec.describe Kozo::Types::Integer do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "casts a integer value" do
      expect(described_class.cast("3")).to eq 3
    end

    it "does not cast invalid values" do
      expect { described_class.cast("3.14") }.to raise_error ArgumentError
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end
end
