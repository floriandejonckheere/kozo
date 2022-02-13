# frozen_string_literal: true

RSpec.describe Kozo::Commands::State::Upgrade do
  subject(:command) { build(:state_upgrade_command, configuration: configuration) }

  let(:resource) { build(:dummy_resource, id: "dummy", state_name: "dummy") }

  let(:state) { build(:state, resources: [resource], version: version) }
  let(:configuration) { build(:configuration, backend: build(:memory_backend, state: state), resources: [resource]) }

  let(:version) { Kozo::State::VERSION }

  context "when the state is up to date" do
    it "returns without doing anything" do
      expect { command.start }.to log "already up to date"
    end
  end

  context "when the state is out of date" do
    let(:version) { 0 }

    it "upgrades the state file" do
      expect { command.start }.to log "to version 1"
    end
  end
end
