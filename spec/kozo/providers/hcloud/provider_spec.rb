# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Provider do
  subject(:provider) { described_class.new }

  it { is_expected.to respond_to :key, :key= }

  it "has a name" do
    expect(described_class.name).to eq "hcloud"
  end
end
