# frozen_string_literal: true

RSpec.describe Kozo::State do
  subject(:state) { build(:state, resources: [resource], version: version) }

  let(:resource) { build(:dummy_resource) }
  let(:version) { described_class::VERSION }

  describe "#compatible?" do
    it { is_expected.to be_compatible }

    context "when the state version does not match the current version" do
      let(:version) { 0 }

      it { is_expected.not_to be_compatible }
    end
  end

  describe "#to_h" do
    it "transforms state into a hash" do
      expect(state.to_h).to include resources: [resource.to_h]
    end
  end
end
