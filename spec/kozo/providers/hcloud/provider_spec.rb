# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Provider do
  subject(:provider) { build(:hcloud) }

  it { is_expected.to respond_to :key, :key= }

  it "has a name" do
    expect(described_class.provider_name).to eq "hcloud"
  end
end
