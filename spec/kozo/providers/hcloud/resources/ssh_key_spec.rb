# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Resources::SSHKey do
  subject(:resource) { described_class.new }

  it { is_expected.to respond_to :name, :name= }
  it { is_expected.to respond_to :public_key, :public_key= }

  it "has a name" do
    expect(described_class.name).to eq "hcloud_ssh_key"
  end
end
