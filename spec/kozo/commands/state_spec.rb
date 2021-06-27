# frozen_string_literal: true

RSpec.describe Kozo::Commands::State do
  describe Kozo::Commands::State::List do
    subject(:command) { described_class.new }

    let(:resource) { build(:resource, id: "my_id") }
    let(:state) { build(:state, resources: [resource]) }

    before do
      allow(command)
        .to receive(:state)
        .and_return state
    end

    describe "#start" do
      it "lists all resources in the state" do
        expect { command.start }.to output(/my_id/).to_stdout
      end
    end
  end
end
