# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Resource do
  subject(:resource) { described_class.new }

  it "has a provider" do
    expect(described_class.provider_name).to eq "hcloud"
  end

  it "casts id to integer" do
    resource.send(:id=, "123")

    expect(resource.id).to eq 123
  end
end
