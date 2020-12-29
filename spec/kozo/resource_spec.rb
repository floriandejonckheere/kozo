# frozen_string_literal: true

RSpec.describe Kozo::Resource do
  subject(:resource) { resource_class.new }

  let(:resource_class) do
    Class.new(described_class) do
      self.provider_name = "provider"
      self.resource_name = "name"
    end
  end

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
      expect(resource.to_h).to include provider: "provider",
                                       resource: "name"
    end
  end
end
