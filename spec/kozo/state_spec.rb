# frozen_string_literal: true

RSpec.describe Kozo::State do
  subject(:state) { build(:state, resources: [resource]) }

  let(:resource) { build(:null_resource) }

  describe "#to_h" do
    it "transforms state into a hash" do
      expect(state.to_h).to include resources: [resource.to_h]
    end
  end
end
