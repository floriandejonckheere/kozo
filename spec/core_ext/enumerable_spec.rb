# frozen_string_literal: true

RSpec.describe CoreExt::NilClass do
  subject(:enumerable) { [:foo, :bar, :baz] }

  describe "#intersperse" do
    it "intersperses a value" do
      expect(enumerable.intersperse("value")).to eq [:foo, "value", :bar, "value", :baz]
    end
  end

  describe "#as_s" do
    context "when the enumerable is empty" do
      subject(:enumerable) { [] }

      it "serializes correctly" do
        expect(enumerable.as_s).to eq "["
      end
    end

    it "serializes correctly" do
      expect(enumerable.as_s).to eq "[
  \"foo\",
  \"bar\",
  \"baz\"
]"
    end
  end
end
