# frozen_string_literal: true

RSpec.describe Kozo::Providers::Null::Resources::Null do
  subject(:resource) { described_class.new }

  it "has a name" do
    expect(described_class.name).to eq "null"
  end
end
