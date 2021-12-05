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
end
