# frozen_string_literal: true

RSpec.describe Kozo::Commands::Plan do
  subject(:command) { build(:plan_command, configuration: configuration) }

  let(:resource0) { build(:dummy_resource, state_name: "resource0", name: "name0", description: "description0", location: "eu", locked: false, id: nil) }
  let(:resource1) { build(:dummy_resource, state_name: "resource1", name: "name1", description: "description1", location: "eu", locked: false) }
  let(:resource2) { build(:dummy_resource, state_name: "resource2", name: "name2", description: "description2", location: "eu", locked: false) }

  let(:resource1_modified) { build(:dummy_resource, state_name: "resource1", id: resource1.id, name: "old name1", description: "description1", location: "eu", locked: false) }

  let(:state) { build(:state, resources: [resource1_modified, resource2]) }
  let(:configuration) { build(:configuration, backend: build(:memory_backend, state: state), resources: [resource0, resource1]) }

  it "plans an addition of a resource" do
    expect { command.start }.to log <<~LOG.chomp
      # dummy.resource0:
      + resource "dummy", "resource0" do |r|
          r.id          = (known after apply)
        + r.name        = "name0"
        + r.description = "description0"
          r.location    = (known after apply)
          r.locked      = (known after apply)
          r.labels      = (known after apply)
      end
    LOG
  end

  it "plans a modification of a resource" do
    expect { command.start }.to log <<~LOG.chomp
      # dummy.resource1:
      ~ resource "dummy", "resource1" do |r|
          r.id          = "#{resource1.id}"
        ~ r.name        = "old name1" -> "name1"
          r.description = "description1"
          r.location    = "eu"
          r.locked      = false
          r.labels      = []
      end
    LOG
  end

  it "plans a deletion of a resource" do
    expect { command.start }.to log <<~LOG.chomp
      # dummy.resource2:
      - resource "dummy", "resource2" do |r|
        - r.id          = "#{resource2.id}"
        - r.name        = "name2"
        - r.description = "description2"
        - r.location    = "eu"
        - r.locked      = false
        - r.labels      = []
      end
    LOG
  end

  context "when nothing can be done" do
    let(:state) { build(:state, resources: [resource0, resource1]) }

    # Resource must have an ID, otherwise it is marked as to be created
    before { resource0.id = "id0" }

    it "plans nothing" do
      expect { command.start }.to log("No actions have to be performed")
    end
  end
end
