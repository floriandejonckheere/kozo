# frozen_string_literal: true

RSpec.describe Kozo::Backend do
  subject(:backend) { backend_class.new(configuration, "directory", state) }

  let(:backend_class) do
    Class.new(described_class) do
      attr_accessor :data

      def initialize(configuration, directory, data)
        super(configuration, directory)
        @data = data.to_h
      end
    end
  end

  let(:configuration) { build(:configuration, providers: { "dummy" => provider }) }
  let(:state) { build(:state, resources: [resource]) }
  let(:resource) { build(:dummy_resource, provider: provider) }
  let(:provider) { build(:dummy) }

  describe "#state" do
    it "raises when provider is not configured" do
      configuration.providers = {}

      expect { backend.state.resources }.to raise_error Kozo::StateError
    end

    it "reads resources" do
      backend.data = state.to_h

      expect(backend.state.resources).to include resource
    end
  end

  describe "#state=" do
    it "writes resources" do
      backend.state = state

      expect(backend.data).to include resources: [resource.to_h]
    end
  end
end
