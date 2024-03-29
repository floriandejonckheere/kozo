# frozen_string_literal: true

RSpec.describe CoreExt::NilClass do
  subject(:nil_class) { nil }

  describe "#to_b" do
    it "returns nil" do
      expect(nil.to_b).to be_nil
    end
  end

  describe "#as_h" do
    it "returns nil" do
      expect(nil.as_h).to be_nil
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect(nil.as_s).to eq "nil"
    end
  end
end
