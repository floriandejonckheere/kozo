# frozen_string_literal: true

RSpec.describe CoreExt::String do
  subject(:string) { "a string" }

  describe "#to_b" do
    it "returns nil when the string is blank" do
      expect("".to_b).to be_nil
    end

    it "returns false when the string is falsey" do
      expect("false".to_b).to be false
      expect("OFF".to_b).to be false
    end

    it "returns true when the string is truthy" do
      expect("true".to_b).to be true
      expect("1".to_b).to be true
    end
  end

  describe "#as_h" do
    it "returns the string representation" do
      expect(string.as_h).to eq "a string"
    end
  end

  describe "#as_s" do
    it "serializes correctly" do
      expect("a string".as_s).to eq "\"a string\""

      expect("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".as_s)
        .to eq "\"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrst...\""

      expect("abc\ndef".as_s).to eq "\"abc def\""
    end
  end
end
