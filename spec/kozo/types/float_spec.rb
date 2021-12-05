# frozen_string_literal: true

RSpec.describe Kozo::Types::Float do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "casts a float value" do
      expect(described_class.cast("3.14")).to eq 3.14
      expect(described_class.cast("3")).to eq 3.0
    end

    it "does not cast invalid values" do
      expect { described_class.cast("invalid") }.to raise_error ArgumentError
    end
  end

  describe ".as_json" do
    it "does not serialize nil" do
      expect(described_class.as_json(nil)).to eq nil
    end

    it "serializes floats correctly" do
      expect(described_class.as_json(3.14)).to eq 3.14
    end
  end

  describe ".as_s" do
    it "serializes nil" do
      expect(described_class.as_s(nil)).to eq "nil"
    end

    it "serializes floats correctly" do
      expect(described_class.as_s(3.14)).to eq "3.14"
    end
  end
end
