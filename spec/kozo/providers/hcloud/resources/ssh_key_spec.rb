# frozen_string_literal: true

require "hcloud"

RSpec.describe Kozo::Providers::HCloud::Resources::SSHKey do
  subject(:resource) { build(:hcloud_ssh_key, name: "old_name", public_key: "old_public_key") }

  let(:client) { instance_double(Hcloud::Client, "client") }
  let(:ssh_keys) { instance_double(Hcloud::SSHKeyResource, "ssh_keys") }

  before do
    allow(resource.provider).to receive(:client).and_return client
    allow(client).to receive(:ssh_keys).and_return ssh_keys
  end

  it { is_expected.to respond_to :name, :name= }
  it { is_expected.to respond_to :public_key, :public_key= }

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

  describe "#create!" do
    it "creates a resource" do
      allow(ssh_keys)
        .to receive(:create)
        .with(name: "old_name", public_key: "old_public_key")
        .and_return OpenStruct.new(id: 12_345, name: "new_name", public_key: "new_public_key")

      resource.create!

      expect(resource.id).to eq 12_345
      expect(resource.name).to eq "new_name"
      expect(resource.public_key).to eq "new_public_key"
    end
  end

  describe "#destroy!" do
    it "destroys a resource" do
      mock = double

      allow(ssh_keys)
        .to receive(:find)
        .with(resource.id)
        .and_return mock

      allow(mock)
        .to receive(:destroy)

      resource.destroy!

      expect(mock)
        .to have_received(:destroy)
    end
  end
end
