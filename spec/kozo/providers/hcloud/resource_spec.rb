# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Resource do
  subject(:resource) { described_class }

  describe ".provider" do
    it "returns the provider class" do
      expect(resource.provider).to eq Kozo::Providers::HCloud::Provider
    end
  end
end
