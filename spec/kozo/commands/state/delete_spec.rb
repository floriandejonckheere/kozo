# frozen_string_literal: true

RSpec.describe Kozo::Commands::State::Show do
  subject(:command) { build(:state_delete_command, state: state, args: address) }

  let(:resource) { build(:dummy_resource, id: "dummy", state_name: "dummy") }
  let(:state) { build(:state, resources: [resource]) }

  let(:address) { resource.address }

  it "deletes a resource from the state" do
    expect(state.resources).not_to be_empty

    expect { command.start }.to log("dummy.dummy")

    expect(state.resources).to be_empty
  end

  context "when the resource does not exist" do
    let(:address) { "foo.bar" }

    it "raises an error" do
      expect { command.start }.to raise_error Kozo::StateError
    end
  end
end
