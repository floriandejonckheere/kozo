# frozen_string_literal: true

RSpec.describe CoreExt::String do
  subject(:string) { "a string" }

  describe "#to_b" do
    it "returns nil when the string is blank" do
      expect("".to_b).to eq nil
    end

    it "returns false when the string is falsey" do
      expect("false".to_b).to eq false
      expect("OFF".to_b).to eq false
    end

    it "returns true when the string is truthy" do
      expect("true".to_b).to eq true
      expect("1".to_b).to eq true
    end
  end
end
