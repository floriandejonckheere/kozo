# frozen_string_literal: true

RSpec.describe Kozo::Types::String do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "casts a string value" do
      expect(described_class.cast(:string)).to eq "string"
      expect(described_class.cast(3.14)).to eq "3.14"
    end
  end

  describe ".as_json" do
    it "does not serialize nil" do
      expect(described_class.as_json(nil)).to eq nil
    end

    it "serializes strings correctly" do
      expect(described_class.as_json("string")).to eq "string"
    end
  end

  describe ".as_s" do
    it "serializes nil" do
      expect(described_class.as_s(nil)).to eq "nil"
    end

    it "serializes strings correctly" do
      expect(described_class.as_s("string")).to eq "\"string\""
    end
  end
end
