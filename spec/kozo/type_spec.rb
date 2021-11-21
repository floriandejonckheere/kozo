# frozen_string_literal: true

RSpec.describe Kozo::Type do
  subject(:type) { described_class.new }

  describe ".lookup" do
    it "returns a type class" do
      expect(described_class.lookup(:string)).to eq Kozo::Types::String
    end

    it "raises when no corresponding type registered" do
      expect { described_class.lookup :foo }.to raise_error ArgumentError
    end
  end
end
