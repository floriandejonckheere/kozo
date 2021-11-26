# frozen_string_literal: true

RSpec.describe Kozo::Types::Boolean do
  subject(:type) { described_class.new }

  describe ".cast" do
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

  describe ".serialize" do
    it "serializes correctly" do
      expect(described_class.serialize(true)).to eq true
      expect(described_class.serialize(false)).to eq false
    end
  end
end
