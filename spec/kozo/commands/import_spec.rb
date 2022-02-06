# frozen_string_literal: true

RSpec.describe Kozo::Commands::Import do
  subject(:command) { build(:import_command, configuration: configuration, args: [address, id]) }

  let(:resource0) { build(:dummy_resource, state_name: "resource0", name: "name0", description: "description0", location: "eu", locked: false) }
  let(:resource1) { build(:dummy_resource, state_name: "resource1", name: "name1", description: "description1", location: "eu", locked: false, id: nil) }

  let(:state) { build(:state, resources: [resource0]) }
  let(:configuration) { build(:configuration, backend: build(:memory_backend, state: state), resources: [resource0, resource1]) }

  let(:address) { resource1.address }
  let(:id) { "id" }

  it "imports a resource into the state" do
    allow(resource1)
      .to receive(:refresh!)
      .and_return true

    command.start

    expect(resource1.id).to eq "id"
  end

  context "when the resource does not exist in the configuration" do
    let(:address) { "foo.bar" }

    it "raises an error" do
      expect { command.start }.to raise_error Kozo::StateError
    end
  end

  context "when the address was not specified" do
    let(:address) { nil }

    it "raises an error" do
      expect { command.start }.to raise_error Kozo::UsageError
    end
  end

  context "when the ID was not specified" do
    let(:id) { nil }

    it "raises an error" do
      expect { command.start }.to raise_error Kozo::UsageError
    end
  end

  context "when the remote resource does not exist"
end
