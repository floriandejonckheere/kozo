# frozen_string_literal: true

RSpec.describe Kozo::Environment do
  subject(:environment) { described_class.new(Dir.pwd, configuration) }

  let(:state) { [] }
  let(:resources) { [] }
  let(:configuration) { build(:configuration, resources: resources, backend: build(:local_backend, state: build(:state, resources: state))) }

  context "when resources have to be created" do
    let(:state) { [] }
    let(:resources) { [build(:null_resource, id: nil, state_name: "state_name", name: "name")] }

    it "marks resource for creation" do
      expect(environment.resources.count).to eq 1

      resource = environment.resources.first

      expect(resource).to be_marked_for_creation
      expect(resource.changes.symbolize_keys).to eq name: [nil, "name"]
    end
  end

  context "when resources have to be updated" do
    let(:state) { [build(:null_resource, id: "id", state_name: "state_name", name: "name")] }
    let(:resources) { [build(:null_resource, id: nil, state_name: "state_name", name: "new name")] }

    it "marks resource for update" do
      expect(environment.resources.count).to eq 1

      resource = environment.resources.first

      expect(resource.changes.symbolize_keys).to eq name: ["name", "new name"]
    end
  end

  context "when resources have to be deleted" do
    let(:state) { [build(:null_resource, id: "id", state_name: "state_name", name: "name")] }
    let(:resources) { [] }

    it "marks resource for deletion" do
      expect(environment.resources.count).to eq 1

      resource = environment.resources.first

      expect(resource).to be_marked_for_deletion
      expect(resource.changes.symbolize_keys).to eq name: ["name", nil]
    end
  end
end
