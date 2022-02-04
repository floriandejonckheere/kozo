# frozen_string_literal: true

RSpec.describe Kozo::Commands::State::Show do
  subject(:command) { build(:state_show_command, configuration: configuration, args: address) }

  let(:resource) { build(:dummy_resource, id: "dummy", state_name: "dummy") }

  let(:state) { build(:state, resources: [resource]) }
  let(:configuration) { build(:configuration, backend: build(:memory_backend, state: state), resources: [resource]) }

  let(:address) { resource.address }

  it "shows a resource in the state" do
    expect { command.start }.to log(/id *= "dummy"/)
  end

  context "when the resource does not exist" do
    let(:address) { "foo.bar" }

    it "raises an error" do
      expect { command.start }.to raise_error Kozo::StateError
    end
  end
end
