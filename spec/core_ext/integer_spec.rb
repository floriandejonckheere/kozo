# frozen_string_literal: true

RSpec.describe CoreExt::Integer do
  subject(:integer) { 3 }

  describe "#as_s" do
    it "serializes correctly" do
      expect(3.as_s).to eq "3"
    end
  end
end
