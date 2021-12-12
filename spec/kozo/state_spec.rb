# frozen_string_literal: true

RSpec.describe Kozo::State do
  subject(:state) { build(:state, resources: [resource]) }

  let(:resource) { build(:dummy_resource) }

  describe ".new" do
    it "raises when version does not match" do
      expect { described_class.new([resource], 0, Kozo::VERSION) }.to raise_error Kozo::StateError
    end

    it "raises when kozo version does not match" do
      expect { described_class.new([resource], described_class::VERSION, 0) }.to raise_error Kozo::StateError
    end

    it "validates the state file" do
      expect { described_class.new([resource], described_class::VERSION, Kozo::VERSION) }.not_to raise_error
    end
  end

  describe "#to_h" do
    it "transforms state into a hash" do
      expect(state.to_h).to include resources: [resource.to_h]
    end
  end
end
