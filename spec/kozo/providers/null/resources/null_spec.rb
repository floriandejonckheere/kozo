# frozen_string_literal: true

RSpec.describe Kozo::Providers::Null::Resources::Null do
  subject(:resource) { build(:null_resource) }

  it "has a name" do
    expect(described_class.resource_name).to eq "null"
  end
end
