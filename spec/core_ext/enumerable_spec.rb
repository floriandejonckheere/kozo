# frozen_string_literal: true

RSpec.describe CoreExt::NilClass do
  subject(:enumerable) { [:foo, :bar, :baz] }

  describe "#intersperse" do
    it "intersperses a avlue" do
      expect(enumerable.intersperse("value")).to eq [:foo, "value", :bar, "value", :baz]
    end
  end
end
