# frozen_string_literal: true

RSpec.describe Kozo::Backends::Base do
  subject(:backend) { backend_class.new(directory, state) }

  let(:backend_class) do
    Class.new(described_class) do
      attr_reader :state

      def initialize(directory, state)
        super(directory)
        @state = state
      end
    end
  end

  let(:directory) { "directory" }
  let(:state) { build(:state) }

  describe "#providers" do
    it "returns a list of providers" do
      expect(backend.providers).to match_array state[:providers]
    end
  end

  describe "#resources" do
    it "returns a list of resources" do
      expect(backend.resources).to match_array state[:resources]
    end
  end
end
