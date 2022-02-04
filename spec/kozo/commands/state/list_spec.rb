# frozen_string_literal: true

RSpec.describe Kozo::Commands::State::List do
  subject(:command) { build(:state_list_command, state: state) }

  let(:resource) { build(:dummy_resource, id: "dummy", state_name: "dummy") }
  let(:state) { build(:state, resources: [resource]) }

  let(:address) { resource.address }

  it "lists all resources in the state" do
    expect { command.start }.to log("dummy.dummy")
  end
end
