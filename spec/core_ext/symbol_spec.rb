# frozen_string_literal: true

RSpec.describe CoreExt::Symbol do
  subject(:symbol) { :symbol }

  describe "#as_s" do
    it "serializes correctly" do
      expect(symbol.as_s).to eq "\"symbol\""
    end
  end
end
