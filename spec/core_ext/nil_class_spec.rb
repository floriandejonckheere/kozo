# frozen_string_literal: true

RSpec.describe CoreExt::NilClass do
  subject(:nil_class) { nil }

  describe "#to_b" do
    it "returns nil" do
      expect(nil.to_b).to eq nil
    end
  end
end
