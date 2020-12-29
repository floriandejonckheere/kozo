# frozen_string_literal: true

RSpec.describe Kozo::Resource do
  subject(:resource) { build(:null_resource) }

  it { is_expected.to respond_to :id, :id= }
  it { is_expected.to respond_to :provider, :provider= }

  it "has a name" do
    expect(described_class).to respond_to :resource_name, :resource_name=
  end

  it "has a provider" do
    expect(described_class).to respond_to :provider_name, :provider_name=
  end

  describe "#to_h" do
    it "transforms resource into a hash" do
      expect(resource.to_h).to include meta: { provider: "null", resource: "null" },
                                       data: {}
    end
  end

  describe ".from_h" do
    it "transforms hash into a resource" do
      expect(described_class.from_h(resource.to_h)).to eq resource
    end
  end
end
