# frozen_string_literal: true

RSpec.describe Kozo::Types::String do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "casts a string value" do
      expect(described_class.cast(:string)).to eq "string"
      expect(described_class.cast(3.14)).to eq "3.14"
    end
  end

  describe ".serialize" do
    it "serializes strings correctly" do
      expect(described_class.serialize("string")).to eq "string"
    end
  end
end
