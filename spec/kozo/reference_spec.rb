# frozen_string_literal: true

RSpec.describe Kozo::Reference do
  subject(:reference) { described_class.new(resource_class: resource.class) }

  let(:resource) { build(:dummy_resource, id: "id", state_name: "dummy") }

  let(:state) { build(:state, resources: [resource]) }
  let(:configuration) { build(:configuration, backend: build(:memory_backend, state: state), resources: [resource]) }

  describe "#state_name" do
    it "sets the state name" do
      reference.name

      expect(reference.state_name).to eq "name"
    end

    it "sets the state name only once" do
      reference.name

      expect { reference.another_name }.to raise_error NoMethodError
    end
  end

  describe "#as_h" do
    it "returns the ID as representation" do
      reference.dummy

      reference.resolve(configuration)

      expect(reference.as_h).to eq "id"
    end
  end

  describe "#to_h" do
    it "transforms reference into a hash" do
      reference.dummy

      reference.resolve(configuration)

      expect(reference.to_h).to include id: "id"
    end
  end

  describe "#resolve" do
    it "resolves correctly" do
      reference.dummy

      reference.resolve(configuration)

      expect(reference.id).to eq "id"
    end

    context "when the resource ID is nil" do
      let(:resource) { build(:dummy_resource, state_name: "dummy", id: nil) }

      it "resolves to nil" do
        reference.dummy

        reference.resolve(configuration)

        expect(reference.id).to be_nil
      end
    end

    it "raises an error when no state name was specified" do
      expect { reference.resolve(configuration) }.to raise_error Kozo::StateError
    end

    it "raises an error when no resource was found in the configuration" do
      reference.no_dummy

      expect { reference.resolve(configuration) }.to raise_error Kozo::StateError
    end
  end
end
