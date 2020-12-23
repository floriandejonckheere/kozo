# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Resource do
  subject(:resource) { described_class.new }

  it "has a provider" do
    expect(described_class.provider).to eq "hcloud"
  end
end
