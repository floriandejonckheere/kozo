# frozen_string_literal: true

RSpec.describe Kozo::Command do
  subject(:command) { build(:command, configuration: configuration) }

  let(:configuration) { build(:configuration, resources: resources, backend: build(:local_backend, state: build(:state, resources: state))) }
  let(:state) { [] }
  let(:resources) { [] }

  describe "#changes" do
    context "when resources have to be created" do
      let(:state) { [] }
      let(:resources) { [build(:dummy_resource, id: nil, state_name: "state_name", name: "name", description: "description")] }

      it "marks resource for creation" do
        expect(command.changes.count).to eq 1

        resource = command.changes.first

        expect(resource.id).to be_nil
        expect(resource.changes.symbolize_keys).to eq name: [nil, "name"], description: [nil, "description"]
      end
    end

    context "when resources have to be updated" do
      let(:state) { [build(:dummy_resource, id: "id", state_name: "state_name", name: "name", description: "description")] }
      let(:resources) { [build(:dummy_resource, id: nil, state_name: "state_name", name: "new name", description: "new description")] }

      it "marks resource for update" do
        expect(command.changes.count).to eq 1

        resource = command.changes.first

        expect(resource.changes.symbolize_keys).to eq name: ["name", "new name"], description: ["description", "new description"]
      end
    end

    context "when resources have to be deleted" do
      let(:state) { [build(:dummy_resource, id: "id", state_name: "state_name", name: "name", description: "description")] }
      let(:resources) { [] }

      it "marks resource for deletion" do
        expect(command.changes.count).to eq 1

        resource = command.changes.first

        expect(resource.id).to be_nil
        expect(resource.changes.symbolize_keys).to include id: ["id", nil], name: ["name", nil], description: ["description", nil]
      end
    end
  end
end
