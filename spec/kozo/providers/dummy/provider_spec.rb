# frozen_string_literal: true

RSpec.describe Kozo::Providers::Dummy::Provider do
  subject(:provider) { build(:dummy) }

  it "has a name" do
    expect(described_class.provider_name).to eq "dummy"
  end
end
