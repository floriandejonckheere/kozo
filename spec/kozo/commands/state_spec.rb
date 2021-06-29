# frozen_string_literal: true

RSpec.describe Kozo::Commands::State do
  describe Kozo::Commands::State::List do
    subject(:command) { described_class.new }

    let(:resource) { build(:null_resource, id: "null", state_name: "null") }
    let(:state) { build(:state, resources: [resource]) }

    before do
      allow(command)
        .to receive(:state)
        .and_return state
    end

    it "lists all resources in the state" do
      expect { command.start }.to output("null.null\n").to_stdout
    end
  end
end
