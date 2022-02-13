# frozen_string_literal: true

RSpec.describe CoreExt::Date do
  subject(:date) { Date.new(2000, 1, 1) }

  describe "#as_h" do
    it "returns the string representation" do
      expect(date.as_h).to eq "2000-01-01"
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(date.as_s).to eq "2000-01-01"
    end
  end
end
