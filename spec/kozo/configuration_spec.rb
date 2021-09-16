# frozen_string_literal: true

RSpec.describe Kozo::Configuration do
  subject(:configuration) { build(:configuration) }

  it "defaults to local backend" do
    expect(configuration.backend).to be_a Kozo::Backends::Local
  end

  describe "#changes" do
    subject(:configuration) { build(:configuration, resources: resources, backend: build(:local_backend, state: build(:state, resources: state))) }

    let(:state) { [] }
    let(:resources) { [] }

    context "when resources have to be created" do
      let(:state) { [] }
      let(:resources) { [build(:dummy_resource, id: nil, state_name: "state_name", name: "name", description: "description")] }

      it "marks resource for creation" do
        expect(configuration.changes.count).to eq 1

        resource = configuration.changes.first

        expect(resource).to be_marked_for_creation
        expect(resource.changes.symbolize_keys).to eq name: [nil, "name"], description: [nil, "description"]
      end
    end

    context "when resources have to be updated" do
      let(:state) { [build(:dummy_resource, id: "id", state_name: "state_name", name: "name", description: "description")] }
      let(:resources) { [build(:dummy_resource, id: nil, state_name: "state_name", name: "new name", description: "new description")] }

      it "marks resource for update" do
        expect(configuration.changes.count).to eq 1

        resource = configuration.changes.first

        expect(resource.changes.symbolize_keys).to eq name: ["name", "new name"], description: ["description", "new description"]
      end
    end

    context "when resources have to be deleted" do
      let(:state) { [build(:dummy_resource, id: "id", state_name: "state_name", name: "name", description: "description")] }
      let(:resources) { [] }

      it "marks resource for deletion" do
        expect(configuration.changes.count).to eq 1

        resource = configuration.changes.first

        expect(resource).to be_marked_for_deletion
        expect(resource.changes.symbolize_keys).to eq id: ["id", nil], name: ["name", nil], description: ["description", nil]
      end
    end
  end
end
