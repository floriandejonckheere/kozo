# frozen_string_literal: true

RSpec.describe CoreExt::Float do
  subject(:float) { 3.14 }

  describe "#as_h" do
    it "returns the floating point representation" do
      expect(3.14.as_h).to eq 3.14
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(3.14.as_s).to eq "3.14"
    end
  end
end
