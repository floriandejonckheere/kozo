# frozen_string_literal: true

RSpec.describe CoreExt::Integer do
  subject(:integer) { 3 }

  describe "#as_h" do
    it "returns the integer representation" do
      expect(3.as_h).to eq 3
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(3.as_s).to eq "3"
    end
  end
end
