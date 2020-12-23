# frozen_string_literal: true

RSpec.describe Kozo::Backend do
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
end
