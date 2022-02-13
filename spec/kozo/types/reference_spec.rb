# frozen_string_literal: true

RSpec.describe Kozo::Types::Reference do
  subject(:type) { described_class.new }

  describe ".cast" do
    it "does not cast nil" do
      expect(described_class.cast(nil)).to eq nil
    end

    it "does not cast a reference" do
      reference = Kozo::Reference.new

      expect(described_class.cast(reference)).to eq reference
    end

    it "does not cast non-resource objects" do
      expect(described_class.cast("foobar")).to be_nil
    end

    it "casts a resource" do
      resource = build(:dummy_resource)

      reference = described_class.cast(resource)

      expect(reference.resource_class).to eq resource.class
      expect(reference.id).to eq resource.id
      expect(reference.state_name).to eq resource.state_name
    end
  end
end
