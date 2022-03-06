# frozen_string_literal: true

RSpec.describe Kozo::Types::Boolean do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to be_nil
    end

    described_class::FALSE_VALUES.each do |value|
      it "casts a falsey value: #{value}" do
        expect(described_class.cast(value)).to be false
      end
    end

    it "casts a truthy value" do
      expect(described_class.cast(true)).to be true
      expect(described_class.cast("foo")).to be true
      expect(described_class.cast(:foo)).to be true
    end
  end
end
