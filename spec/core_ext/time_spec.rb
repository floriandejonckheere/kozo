# frozen_string_literal: true

RSpec.describe CoreExt::Time do
  subject(:time) { Time.find_zone("UTC").local(2000, 1, 1, 12) }

  describe "#as_s" do
    it "serializes correctly" do
      expect(time.as_s).to eq "2000-01-01T12:00:00Z"
    end
  end
end
