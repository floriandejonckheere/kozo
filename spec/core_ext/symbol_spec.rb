# frozen_string_literal: true

RSpec.describe CoreExt::Symbol do
  subject(:symbol) { :symbol }

  describe "#as_h" do
    it "returns the string representation" do
      expect(symbol.as_h).to eq "symbol"
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(symbol.as_s).to eq "\"symbol\""
    end
  end
end
