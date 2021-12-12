# frozen_string_literal: true

RSpec.describe CoreExt::Hash do
  subject(:hash) { { foo: "bar", baz: false } }

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
