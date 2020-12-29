# frozen_string_literal: true

RSpec.describe Kozo::Backend do
  subject(:backend) { backend_class.new(configuration, directory, state) }

  let(:backend_class) do
    Class.new(described_class) do
      attr_accessor :data

      def initialize(configuration, directory, data)
        super(configuration, directory)
        @data = data.to_h
      end
    end
  end

  let(:configuration) { build(:configuration, providers: { "null" => provider }) }
  let(:directory) { "directory" }
  let(:state) { build(:state, resources: [resource]) }
  let(:resource) { build(:null_resource, provider: provider) }
  let(:provider) { build(:null_provider) }

  describe "#state" do
    it "raises when provider is not configured" do
      configuration.providers = {}

      expect { backend.state.resources }.to raise_error Kozo::Backend::InvalidState
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

  describe "#validate!" do
    it "raises when version does not match" do
      backend.data = { version: 0, kozo_version: Kozo::VERSION }

      expect { backend.validate! }.to raise_error Kozo::Backend::InvalidState
    end

    it "raises when kozo version does not match" do
      backend.data = { version: Kozo::State::VERSION, kozo_version: 0 }

      expect { backend.validate! }.to raise_error Kozo::Backend::InvalidState
    end

    it "validates the state file" do
      backend.data = { version: Kozo::State::VERSION, kozo_version: Kozo::VERSION }

      expect { backend.validate! }.not_to raise_error
    end
  end
end
