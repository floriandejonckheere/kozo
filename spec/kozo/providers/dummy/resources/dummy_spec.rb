# frozen_string_literal: true

RSpec.describe Kozo::Providers::Dummy::Resources::Dummy do
  subject(:resource) { build(:dummy_resource) }

  it "has a name" do
    expect(described_class.resource_name).to eq "dummy"
  end
end
