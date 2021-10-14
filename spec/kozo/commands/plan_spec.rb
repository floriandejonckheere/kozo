# frozen_string_literal: true

RSpec.describe Kozo::Commands::Plan do
  subject(:command) { build(:plan_command, configuration: configuration) }

  let(:resource0) { build(:dummy_resource, state_name: "resource0", name: "resource0") }
  let(:resource1) { build(:dummy_resource, state_name: "resource1", name: "resource1") }
  let(:resource2) { build(:dummy_resource, state_name: "resource2", name: "resource2") }

  let(:resource1_modified) { build(:dummy_resource, state_name: "resource1", name: "old name") }

  let(:state) { build(:state, resources: [resource1_modified, resource2]) }
  let(:backend) { build(:memory_backend, state: state) }
  let(:configuration) { build(:configuration, backend: backend, resources: [resource0, resource1]) }

  it "plans an addition of a resource" do
    expect { command.start }.to log("+ dummy.resource0")
  end

  it "plans a modification of a resource" do
    expect { command.start }.to log("~ dummy.resource1")
  end

  it "plans a deletion of a resource" do
    expect { command.start }.to log("- dummy.resource2")
  end

  context "when nothing can be done" do
    let(:state) { build(:state, resources: [resource0, resource1]) }

    it "plans nothing" do
      expect { command.start }.to log("No actions have to be performed")
    end
  end
end
