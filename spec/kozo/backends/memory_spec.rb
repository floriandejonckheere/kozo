# frozen_string_literal: true

RSpec.describe Kozo::Backends::Memory do
  subject(:backend) { build(:memory_backend) }

  let(:state) { { foo: "bar" } }

  describe "#data, #data=" do
    it "sets and gets state in memory" do
      backend.data = state

      expect(backend.data).to eq state
    end
  end
end
