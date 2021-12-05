# frozen_string_literal: true

RSpec.describe Kozo::Types::Boolean do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    described_class::FALSE_VALUES.each do |value|
      it "casts a falsey value: #{value}" do
        expect(described_class.cast(value)).to eq false
      end
    end

    it "casts a truthy value" do
      expect(described_class.cast(true)).to eq true
      expect(described_class.cast("foo")).to eq true
      expect(described_class.cast(:foo)).to eq true
    end
  end

  describe ".as_json" do
    it "does not serialize nil" do
      expect(described_class.as_json(nil)).to eq nil
    end

    it "serializes correctly" do
      expect(described_class.as_json(true)).to eq true
      expect(described_class.as_json(false)).to eq false
    end
  end

  describe ".as_s" do
    it "serializes nil to empty string" do
      expect(described_class.as_s(nil)).to eq "nil"
    end

    it "serializes correctly" do
      expect(described_class.as_s(true)).to eq "true"
      expect(described_class.as_s(false)).to eq "false"
    end
  end
end
