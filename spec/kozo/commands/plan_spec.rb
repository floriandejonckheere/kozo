# frozen_string_literal: true

RSpec.describe Kozo::Commands::Plan do
  subject(:command) { build(:plan_command, state: state, configuration: configuration) }

  let(:resource0) { build(:null_resource, state_name: "resource0", name: "resource0") }
  let(:resource1) { build(:null_resource, state_name: "resource1", name: "resource1") }
  let(:resource2) { build(:null_resource, state_name: "resource2", name: "resource2") }

  let(:resource1_modified) { build(:null_resource, state_name: "resource1", name: "old name") }

  let(:configuration) { build(:configuration, resources: [resource0, resource1]) }
  let(:state) { build(:state, resources: [resource1_modified, resource2]) }

  it "plans an addition of a resource" do
    expect { command.start }.to log("+ null.resource0")
  end

  it "plans a modification of a resource" do
    expect { command.start }.to log("~ null.resource1")
  end

  it "plans a deletion of a resource" do
    expect { command.start }.to log("- null.resource2")
  end

  context "when nothing can be done" do
    let(:configuration) { build(:configuration) }
    let(:state) { build(:state) }

    it "plans nothing" do
      expect { command.start }.to log("No actions have to be performed")
    end
  end
end
