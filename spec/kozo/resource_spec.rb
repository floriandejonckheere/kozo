# frozen_string_literal: true

RSpec.describe Kozo::Resource do
  subject(:resource) { build(:null_resource, id: "null", state_name: "null") }

  it { is_expected.to respond_to :id, :id= }
  it { is_expected.to respond_to :provider, :provider= }
  it { is_expected.to respond_to :state_name, :state_name= }

  describe "class attributes" do
    subject(:resource) { described_class }

    it { is_expected.to respond_to :resource_name, :resource_name= }
    it { is_expected.to respond_to :provider_name, :provider_name= }
  end

  describe "#address" do
    it "returns the resource address" do
      expect(resource.address).to eq "null.null"
    end
  end

  describe "#to_h" do
    it "transforms resource into a hash" do
      expect(resource.to_h).to include meta: { name: "null", provider: "null", resource: "null" },
                                       data: { id: "null" }
    end
  end

  describe ".from_h" do
    it "transforms hash into a resource" do
      expect(described_class.from_h(resource.to_h)).to eq resource
    end
  end
end
