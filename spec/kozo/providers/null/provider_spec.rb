# frozen_string_literal: true

RSpec.describe Kozo::Providers::Null::Provider do
  subject(:provider) { build(:null) }

  it "has a name" do
    expect(described_class.provider_name).to eq "null"
  end
end
