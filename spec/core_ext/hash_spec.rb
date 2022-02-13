# frozen_string_literal: true

RSpec.describe CoreExt::Hash do
  subject(:hash) { { foo: :bar, baz: false } }

  describe "#as_h" do
    context "when the hash is empty" do
      subject(:hash) { {} }

      it "returns an empty hash" do
        expect(hash.as_h).to be_empty
      end
    end

    it "sends #as_h to every value" do
      expect(hash.as_h).to eq foo: "bar", baz: false
    end
  end

  describe "#as_s" do
    context "when the hash is empty" do
      subject(:hash) { {} }

      it "serializes correctly" do
        expect(hash.as_s).to eq "{}"
      end
    end

    it "serializes correctly" do
      expect(hash.as_s).to eq "{
  foo = \"bar\",
  baz = false
}"
    end
  end
end
