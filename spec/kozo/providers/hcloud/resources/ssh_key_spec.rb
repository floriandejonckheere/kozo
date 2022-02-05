# frozen_string_literal: true

require "hcloud"

RSpec.describe Kozo::Providers::HCloud::Resources::SSHKey do
  subject(:resource) { build(:hcloud_ssh_key, name: "old_name", public_key: "old_public_key") }

  let(:ssh_key_class) { class_double("HCloud::SSHKey") }
  let(:ssh_key) { instance_double("HCloud::SSHKey") }

  before { stub_const("HCloud::SSHKey", ssh_key_class) }

  it { is_expected.to have_attributes :name, :public_key, :labels, :created }

  it "has a name" do
    expect(described_class.resource_name).to eq "hcloud_ssh_key"
  end

  describe "#refresh!" do
    it "refreshes name and public_key" do
      allow(ssh_key_class)
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
      ssh_key = OpenStruct.new(id: 12_345, name: "new_name", public_key: "new_public_key", create: true)

      allow(ssh_key_class)
        .to receive(:new)
        .with(include name: "old_name", public_key: "old_public_key")
        .and_return ssh_key

      allow(ssh_key)
        .to receive(:create)

      resource.create!

      expect(ssh_key)
        .to have_received(:create)

      expect(resource.id).to eq 12_345
      expect(resource.name).to eq "new_name"
      expect(resource.public_key).to eq "new_public_key"
    end
  end

  describe "#update!" do
    it "updates a resource" do
      ssh_key = OpenStruct.new(name: "new_name", public_key: "new_public_key", update: true)

      allow(ssh_key_class)
        .to receive(:find)
        .with(resource.id)
        .and_return ssh_key

      allow(ssh_key)
        .to receive(:update)

      resource.update!

      expect(ssh_key)
        .to have_received(:update)

      expect(ssh_key.name).to eq "old_name"
      expect(ssh_key.public_key).to eq "old_public_key"
    end
  end

  describe "#destroy!" do
    it "destroys a resource" do
      allow(ssh_key_class)
        .to receive(:find)
        .with(resource.id)
        .and_return ssh_key

      allow(ssh_key)
        .to receive(:delete)

      resource.destroy!

      expect(ssh_key)
        .to have_received(:delete)
    end
  end
end
