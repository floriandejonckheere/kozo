# frozen_string_literal: true

require "hcloud"

RSpec.describe Kozo::Providers::HCloud::Resources::SSHKey do
  subject(:resource) { build(:hcloud_ssh_key) }

  let(:client) { instance_double(Hcloud::Client, "client") }
  let(:ssh_keys) { instance_double(Hcloud::SSHKeyResource, "ssh_keys") }

  before do
    allow(resource.provider).to receive(:client).and_return client
    allow(client).to receive(:ssh_keys).and_return ssh_keys
  end

  it { is_expected.to respond_to :name, :name?, :name= }
  it { is_expected.to respond_to :public_key, :public_key?, :public_key= }

  it "has a name" do
    expect(described_class.resource_name).to eq "hcloud_ssh_key"
  end

  describe "#refresh!" do
    it "refreshes name and public_key" do
      allow(ssh_keys)
        .to receive(:find)
        .with(resource.id)
        .and_return OpenStruct.new(name: "new_name", public_key: "new_public_key")

      resource.refresh!

      expect(resource.name).to eq "new_name"
      expect(resource.public_key).to eq "new_public_key"
    end
  end
end
