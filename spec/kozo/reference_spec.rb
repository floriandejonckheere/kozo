# frozen_string_literal: true

RSpec.describe Kozo::Reference do
  subject(:reference) { described_class.new(resource.class, configuration) }

  let(:resource) { build(:dummy_resource, state_name: "dummy") }
  let(:configuration) { build(:configuration, resources: [resource]) }

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

  describe "#as_s" do
    it "serializes correctly" do
      reference.dummy

      expect(reference.as_s).to eq "\"#{resource.id}\""
    end

    context "when the resource ID is nil" do
      let(:resource) { build(:dummy_resource, state_name: "dummy", id: nil) }

      it "serializes a default message" do
        reference.dummy

        expect(reference.as_s).to eq "(known after apply)"
      end
    end

    it "raises an error when no state name was specified" do
      expect { reference.as_s }.to raise_error Kozo::StateError
    end

    it "raises an error when no resource was found in the configuration" do
      reference.no_dummy

      expect { reference.as_s }.to raise_error Kozo::StateError
    end
  end
end
