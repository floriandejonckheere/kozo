# frozen_string_literal: true

RSpec.describe Kozo::ResourceSet do
  subject(:resource_set) { build(:resource_set) }

  describe "#<<" do
    it "replaces a resource in the set" do
      resource = build(:resource)

      resource_set = build(:resource_set, resources: [resource])

      expect(resource_set).to include resource

      resource_set << resource

      expect(resource_set).to include resource
    end

    it "adds a resource to the set" do
      resource = build(:resource)

      expect(resource_set).not_to include resource

      resource_set << resource

      expect(resource_set).to include resource
    end
  end
end
