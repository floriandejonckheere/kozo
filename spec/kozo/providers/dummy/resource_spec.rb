# frozen_string_literal: true

RSpec.describe Kozo::Providers::Dummy::Resource do
  subject(:resource) { build(:dummy_resource) }

  it "has a provider" do
    expect(described_class.provider_name).to eq "dummy"
  end
end
