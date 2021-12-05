# frozen_string_literal: true

RSpec.describe CoreExt::Boolean do
  subject(:boolean) { true }

  describe "#to_b" do
    it "returns true when it is true" do
      expect(true.to_b).to eq true
    end

    it "returns false when it is false" do
      expect(false.to_b).to eq false
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(true.as_s).to eq "true"
      expect(false.as_s).to eq "false"
    end
  end
end
